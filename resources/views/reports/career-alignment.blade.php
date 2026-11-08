@php
    $system = $report->snapshot ?? [];
    $content = $report->content ?? [];
    $bestFit = $content['best_fit_program'] ?? [];
    $ranked = collect($content['overall_best_fit'] ?? [])->sortBy('rank')->values();
    $programs = $content['recommended_programs'] ?? [];
    $firstName = $system['first_name'] ?? '';
    // Page-break control for rows and bullet points: lists of 5 or fewer stay
    // whole. Longer ones split only if at least half fits on the first page
    // with the heading, and their last 2 stay together, so a page never holds
    // just a few stray rows.
    $kn = function (int $index, int $count): string {
        if ($index >= $count - 1) {
            return '';
        }
        $head = $count <= 5 ? $count : max(3, (int) ceil($count / 2));

        return ($index < $head - 1 || $index >= $count - 2) ? ' class="kn"' : '';
    };
@endphp
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Career Alignment Report - {{ $system['student_name'] ?? '' }}</title>
<style>
    /* Measured from the client's sample report: Letter, 1in margins, Arial 9pt. */
    @page { size: letter; margin: 72pt; }
    body { font-family: Helvetica, Arial, sans-serif; font-size: 9pt; line-height: 10.2pt; color: #000; margin: 0; }
    .page-header { position: fixed; top: -32pt; left: 0; right: 0; font-size: 8pt; line-height: 9pt; }
    /* Same logo as the invoice PDF (548 x 106 px). */
    .page-header img { position: absolute; right: 5.5pt; top: -1.5pt; width: 57pt; height: 11pt; }
    .page-footer { position: fixed; bottom: -36pt; left: 0; right: 0; font-size: 8pt; line-height: 9pt; }
    h1 { font-size: 16pt; line-height: 18pt; margin: 2.5pt 0 13pt; }
    h2 { font-size: 9pt; line-height: 10.2pt; margin: 0 0 13.7pt; page-break-after: avoid; }
    h3 { font-size: 9pt; line-height: 10.2pt; margin: 0 0 13.7pt; page-break-after: avoid; }
    p { margin: 0 0 14pt; }
    ul { margin: 0 0 14pt; padding-left: 36pt; list-style: none; }
    li { margin: 0 0 1.8pt; position: relative; }
    li:before { content: "•"; position: absolute; left: -18.2pt; top: 1.2pt; font-size: 13pt; line-height: 10.2pt; }
    hr { border: 0; border-top: 0.5pt solid #a6a6a6; margin: 18.5pt 0 16.5pt; }
    .meta { font-weight: bold; margin-bottom: 22pt; }
    .meta + hr { margin-top: 0; }
    table { border-collapse: collapse; margin: 0 0 14pt; }
    table.full { width: 100%; }
    th, td { border: 0.5pt solid #bfbfbf; padding: 0 5.4pt; vertical-align: top; text-align: left; }
    th { text-align: center; }
    tr { page-break-inside: avoid; }
    thead tr, .kn, .lead { page-break-after: avoid; }
    .keep { page-break-inside: avoid; }
    ul.joined { margin-bottom: 0; }
    .note { font-size: 8pt; }
</style>
</head>
<body>
<div class="page-header">This document has been created by <strong>Connected Education</strong> to make your study abroad journey easier.<img src="data:image/png;base64,{{ base64_encode(file_get_contents(resource_path('report-assets/connected-logo.png'))) }}" alt="Connected."></div>
<div class="page-footer">Thanks for choosing Connected. Hope this document adds value throughout your journey as an international student.</div>

<h1>Career Alignment Report</h1>
<p class="meta">
    Student Name: {{ $system['student_name'] ?? '' }}<br>
    Date: {{ $report->report_date?->format('F j, Y') }}<br>
    @if ($report->education_level)
        Education Level: {{ $report->education_level }}<br>
    @endif
    Target Country: {{ $report->target_country }}
</p>
<hr>

<div class="section keep">
<h2>1. Introduction</h2>
<p>{{ \App\Models\CareerReport::introductionFor($firstName) }}</p>
</div>
<hr>

<div class="section">
@foreach ($system['industries'] ?? [] as $industry)
    @include('reports.partials.bullet-group', [
        'heading' => $loop->first ? '2. Industries and Departments of Interest' : null,
        'title' => $industry['name'],
        'items' => $industry['departments'],
    ])
@endforeach
@if ($report->include_common_departments && !empty($system['common_departments']))
    @include('reports.partials.bullet-group', ['heading' => null, 'title' => 'Common Departments', 'items' => $system['common_departments']])
@endif
</div>
<hr>

<div class="section">
<h2>3. Personality Highlights</h2>
<table>
    <thead><tr><th>Area</th><th>Your Preference</th></tr></thead>
    <tbody>
        @foreach ($system['personality'] ?? [] as $row)
            <tr{!! $kn($loop->index, $loop->count) !!}><td>{{ $row['area'] }}</td><td>{{ $row['preference'] }}</td></tr>
        @endforeach
    </tbody>
</table>
</div>
<hr>

<div class="section">
<h2>4. Industry &amp; Department Match Analysis</h2>
<table class="full">
    <thead><tr><th style="width: 23%">Industry</th><th style="width: 23%">Department</th><th style="width: 12%">Match Level</th><th>Comments</th></tr></thead>
    <tbody>
        @foreach ($content['match_analysis'] ?? [] as $row)
            <tr{!! $kn($loop->index, $loop->count) !!}><td>{{ $row['industry'] }}</td><td>{{ $row['department'] }}</td><td>{{ $row['match_level'] }}</td><td>{{ $row['comments'] }}</td></tr>
        @endforeach
    </tbody>
</table>
</div>
<hr>

<div class="section">
<h2>5. Overall Best Fit</h2>
<table class="full">
    <thead><tr><th style="width: 7%">Rank</th><th style="width: 24%">Industry</th><th style="width: 24%">Department</th><th>Reason</th></tr></thead>
    <tbody>
        @foreach ($ranked as $row)
            <tr{!! $kn($loop->index, $loop->count) !!}><td style="text-align: center">{{ $row['rank'] }}</td><td>{{ $row['industry'] }}</td><td>{{ $row['department'] }}</td><td>{{ $row['reason'] }}</td></tr>
        @endforeach
    </tbody>
</table>
</div>
<hr>

<div class="section">
<h2>6. {{ $report->target_country }} Cities with Most Opportunities</h2>
<table>
    <thead><tr><th>City</th><th>Key Advantages</th></tr></thead>
    <tbody>
        @foreach ($content['cities'] ?? [] as $row)
            <tr{!! $kn($loop->index, $loop->count) !!}><td>{{ $row['city'] }}</td><td>{{ $row['key_advantages'] }}</td></tr>
        @endforeach
    </tbody>
</table>
</div>
<hr>

<div class="section">
@foreach ($content['key_employers'] ?? [] as $group)
    @include('reports.partials.bullet-group', [
        'heading' => $loop->first ? '7. Key Employers' : null,
        'title' => $group['category'],
        'items' => $group['employers'],
    ])
@endforeach
</div>
<hr>

<div class="section">
@foreach ($content['job_titles'] ?? [] as $group)
    @include('reports.partials.bullet-group', [
        'heading' => $loop->first ? '8. Shortlisted Job Titles' : null,
        'title' => $group['category'],
        'items' => $group['titles'],
    ])
@endforeach
</div>
<hr>

<div class="section keep">
<h2>9. Final Recommendation</h2>
<p class="lead">{{ $content['final_recommendation_intro'] ?? '' }}</p>
<ul>
    @foreach ($programs as $program)
        <li{!! $kn($loop->index, $loop->count) !!}>
            <strong>{{ $program['program'] }}</strong>
            @if (!empty($program['licensing_note']))
                <br><span class="note">{{ $program['licensing_note'] }}</span>
            @endif
        </li>
    @endforeach
</ul>
</div>
<hr>

<div class="section keep">
<h2>10. Best Fit Program and Why</h2>
<p class="lead"><strong>Recommended Program:</strong> {{ $bestFit['program'] ?? '' }}</p>
<h3>Why this program fits you best:</h3>
<ul>
    @foreach ($bestFit['why'] ?? [] as $reason)
        <li{!! $kn($loop->index, $loop->count) !!}><strong>{{ $reason['heading'] }}:</strong> {{ $reason['detail'] }}</li>
    @endforeach
</ul>
</div>
<hr>

<div class="section keep">
<h2>11. Conclusion</h2>
@foreach (preg_split('/\n\s*\n/', trim($content['conclusion'] ?? '')) as $paragraph)
    <p>{{ $paragraph }}</p>
@endforeach
<p>Regards,<br>Connected Education Team</p>
</div>
</body>
</html>
