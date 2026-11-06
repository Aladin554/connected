<?php

namespace App\Services\CareerReport;

use App\Models\CareerReport;

/**
 * Structural checks on a report. Errors block approval; warnings are shown to
 * the counsellor. Meaning and tone cannot be judged here, which is why every
 * report also needs a person's approval.
 */
class CareerReportValidator
{
    private array $issues = [];

    /** @return array<int, array{severity: string, message: string}> */
    public function validate(array $content, CareerReport $report, array $snapshot): array
    {
        $this->issues = [];

        $selected = [];
        foreach ($snapshot['industries'] ?? [] as $industry) {
            foreach ($industry['departments'] as $department) {
                $selected[] = $department;
            }
        }
        $selected = array_values(array_unique($selected));

        $this->checkRequiredText($content);
        $this->checkMatchAnalysis($content, $selected);
        $this->checkBestFitRanks($content, $selected);
        $this->checkPrograms($content);
        $this->checkLists($content);
        $this->checkCountry($content, $report);
        $this->checkOptionalTopics($content, $report);

        return $this->issues;
    }

    private function error(string $message): void
    {
        $this->issues[] = ['severity' => 'error', 'message' => $message];
    }

    private function warning(string $message): void
    {
        $this->issues[] = ['severity' => 'warning', 'message' => $message];
    }

    private function checkRequiredText(array $content): void
    {
        $sections = [
            'introduction' => 'Introduction',
            'final_recommendation_intro' => 'Final Recommendation introduction',
            'conclusion' => 'Conclusion',
        ];

        foreach ($sections as $key => $label) {
            if (trim((string) ($content[$key] ?? '')) === '') {
                $this->error("{$label} is empty.");
            }
        }
    }

    private function checkMatchAnalysis(array $content, array $selected): void
    {
        $rows = $content['match_analysis'] ?? [];
        $names = array_column($rows, 'department');

        foreach (array_diff($selected, $names) as $missing) {
            $this->error("Match Analysis is missing the selected department \"{$missing}\".");
        }
        foreach (array_diff($names, $selected) as $extra) {
            $this->error("Match Analysis includes \"{$extra}\", which the student did not select.");
        }
        foreach (array_unique(array_diff_assoc($names, array_unique($names))) as $repeat) {
            $this->error("Match Analysis lists \"{$repeat}\" more than once.");
        }

        $levels = config('career_report.match_levels');
        foreach ($rows as $row) {
            if (!in_array($row['match_level'] ?? null, $levels, true)) {
                $this->error('Match Analysis has an unknown match level for "' . ($row['department'] ?? '?') . '".');
            }
            if (trim((string) ($row['comments'] ?? '')) === '') {
                $this->error('Match Analysis has no comment for "' . ($row['department'] ?? '?') . '".');
            }
            $this->checkLength('Match Analysis comment', $row['comments'] ?? '', $row['department'] ?? '?');
        }
    }

    private function checkBestFitRanks(array $content, array $selected): void
    {
        $rows = $content['overall_best_fit'] ?? [];
        if ($rows === []) {
            $this->error('Overall Best Fit is empty.');

            return;
        }

        $ranks = array_map('intval', array_column($rows, 'rank'));
        sort($ranks);
        if ($ranks !== range(1, count($rows))) {
            $this->error('Overall Best Fit ranks must run 1, 2, 3... with no gaps or repeats.');
        }

        $expected = min(5, count($selected));
        if (count($rows) < $expected) {
            $this->warning("Overall Best Fit ranks " . count($rows) . " departments; {$expected} were expected.");
        }

        foreach ($rows as $row) {
            $this->checkLength('Overall Best Fit reason', $row['reason'] ?? '', $row['department'] ?? '?');
        }

        $names = array_column($rows, 'department');
        foreach (array_diff($names, $selected) as $extra) {
            $this->error("Overall Best Fit includes \"{$extra}\", which the student did not select.");
        }
        foreach (array_unique(array_diff_assoc($names, array_unique($names))) as $repeat) {
            $this->error("Overall Best Fit lists \"{$repeat}\" more than once.");
        }

        // A lower index in match_levels is a stronger match.
        $levels = array_flip(config('career_report.match_levels'));
        $strength = [];
        foreach ($content['match_analysis'] ?? [] as $row) {
            $strength[$row['department'] ?? ''] = $levels[$row['match_level'] ?? ''] ?? null;
        }

        usort($rows, fn (array $a, array $b) => (int) ($a['rank'] ?? 0) <=> (int) ($b['rank'] ?? 0));
        $previous = null;
        foreach ($rows as $row) {
            $current = $strength[$row['department'] ?? ''] ?? null;
            if ($previous !== null && $current !== null && $current < $previous) {
                $this->error('Overall Best Fit ranks "' . $row['department'] . '" below a department with a weaker match level.');
            }
            $previous = $current ?? $previous;
        }
    }

    private function checkLength(string $label, string $text, string $department): void
    {
        $limit = (int) config('career_report.comment_max_characters');
        $length = mb_strlen(trim($text));

        if ($length > $limit) {
            $this->error("{$label} for \"{$department}\" has {$length} characters; the limit is {$limit}, about three lines.");
        }
    }

    private function checkPrograms(array $content): void
    {
        $programs = $content['recommended_programs'] ?? [];
        if ($programs === []) {
            $this->error('Final Recommendation has no programs.');
        }

        $bestFit = trim((string) ($content['best_fit_program']['program'] ?? ''));
        if ($bestFit === '') {
            $this->error('Best Fit Program is empty.');

            return;
        }

        if (preg_match('/\s(or|and\/or)\s|\s\/\s/i', $bestFit)) {
            $this->error("Best Fit Program must be one degree, but it reads \"{$bestFit}\".");
        }

        $match = collect($programs)->first(fn (array $row) => trim((string) ($row['program'] ?? '')) === $bestFit);
        if (!$match) {
            $this->error("Best Fit Program \"{$bestFit}\" is not in the Final Recommendation list.");

            return;
        }

        $topRank = collect($content['overall_best_fit'] ?? [])->firstWhere('rank', 1);
        if ($topRank && ($match['leads_to_department'] ?? null) !== ($topRank['department'] ?? null)) {
            $this->error("Best Fit Program \"{$bestFit}\" does not lead to the rank 1 department \"{$topRank['department']}\".");
        }

        if (empty($content['best_fit_program']['why'])) {
            $this->error('Best Fit Program has no reasons.');
        }
    }

    private function checkLists(array $content): void
    {
        if (count($content['cities'] ?? []) < 3) {
            $this->warning('Fewer than 3 cities are listed.');
        }
        if (empty($content['key_employers'])) {
            $this->error('Key Employers is empty.');
        }
        if (empty($content['job_titles'])) {
            $this->error('Shortlisted Job Titles is empty.');
        }
    }

    private function checkCountry(array $content, CareerReport $report): void
    {
        $text = ($content['introduction'] ?? '') . ' ' . ($content['conclusion'] ?? '');
        $aliases = [
            'United Kingdom' => ['United Kingdom', 'UK', 'Britain'],
            'United States' => ['United States', 'USA', 'US', 'America'],
        ];

        $names = $aliases[$report->target_country] ?? [(string) $report->target_country];
        foreach ($names as $name) {
            if (preg_match('/\b' . preg_quote($name, '/') . '\b/i', $text)) {
                return;
            }
        }

        $this->warning("Neither the Introduction nor the Conclusion mentions {$report->target_country}.");
    }

    private function checkOptionalTopics(array $content, CareerReport $report): void
    {
        $body = $content;
        unset($body['verification_notes']);
        $text = json_encode($body, JSON_UNESCAPED_UNICODE);

        if (!$report->include_immigration
            && preg_match('/permanent resid|\bPR\b|\bvisas?\b|immigration|skilled occupation/i', (string) $text)) {
            $this->error('The report mentions PR, visas or immigration, but that option is switched off.');
        }

        if (!$report->include_future_outlook && preg_match('/automation|automated away/i', (string) $text)) {
            $this->warning('The report mentions automation, but the future outlook option is switched off.');
        }
    }
}
