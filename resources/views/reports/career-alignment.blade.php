@php
    $system = $report->snapshot ?? [];
    $content = $report->content ?? [];
    $bestFit = $content['best_fit_program'] ?? [];
    $ranked = collect($content['overall_best_fit'] ?? [])->sortBy('rank')->values();
    $programs = $content['recommended_programs'] ?? [];
    $firstName = $system['first_name'] ?? '';
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
    .page-header img { position: absolute; right: 5.5pt; top: -2pt; width: 58pt; height: 13.5pt; }
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
    Education Level: {{ $report->education_level }}<br>
    Target Country: {{ $report->target_country }}
</p>
<hr>

<h2>1. Introduction</h2>
<p>Dear {{ $firstName }},</p>
@foreach (preg_split('/\n\s*\n/', trim($content['introduction'] ?? '')) as $paragraph)
    <p>{{ $paragraph }}</p>
@endforeach
<hr>

<h2>2. Industries and Departments of Interest</h2>
@foreach ($system['industries'] ?? [] as $industry)
    <h3>{{ $industry['name'] }}</h3>
    <ul>
        @foreach ($industry['departments'] as $department)
            <li>{{ $department }}</li>
        @endforeach
    </ul>
@endforeach
@if ($report->include_common_departments && !empty($system['common_departments']))
    <h3>Common Departments</h3>
    <ul>
        @foreach ($system['common_departments'] as $department)
            <li>{{ $department }}</li>
        @endforeach
    </ul>
@endif
<hr>

<h2>3. Personality Highlights</h2>
<table>
    <thead><tr><th>Area</th><th>Your Preference</th></tr></thead>
    <tbody>
        @foreach ($system['personality'] ?? [] as $row)
            <tr><td>{{ $row['area'] }}</td><td>{{ $row['preference'] }}</td></tr>
        @endforeach
    </tbody>
</table>
<hr>

<h2>4. Industry &amp; Department Match Analysis</h2>
<table class="full">
    <thead><tr><th style="width: 23%">Industry</th><th style="width: 23%">Department</th><th style="width: 12%">Match Level</th><th>Comments</th></tr></thead>
    <tbody>
        @foreach ($content['match_analysis'] ?? [] as $row)
            <tr><td>{{ $row['industry'] }}</td><td>{{ $row['department'] }}</td><td>{{ $row['match_level'] }}</td><td>{{ $row['comments'] }}</td></tr>
        @endforeach
    </tbody>
</table>
<hr>

<h2>5. Overall Best Fit</h2>
<table class="full">
    <thead><tr><th style="width: 7%">Rank</th><th style="width: 24%">Industry</th><th style="width: 24%">Department</th><th>Reason</th></tr></thead>
    <tbody>
        @foreach ($ranked as $row)
            <tr><td style="text-align: center">{{ $row['rank'] }}</td><td>{{ $row['industry'] }}</td><td>{{ $row['department'] }}</td><td>{{ $row['reason'] }}</td></tr>
        @endforeach
    </tbody>
</table>
<hr>

<h2>6. {{ $report->target_country }} Cities with Most Opportunities</h2>
<table>
    <thead><tr><th>City</th><th>Key Advantages</th></tr></thead>
    <tbody>
        @foreach ($content['cities'] ?? [] as $row)
            <tr><td>{{ $row['city'] }}</td><td>{{ $row['key_advantages'] }}</td></tr>
        @endforeach
    </tbody>
</table>
<hr>

<h2>7. Key Employers</h2>
@foreach ($content['key_employers'] ?? [] as $group)
    <h3>{{ $group['category'] }}</h3>
    <ul>
        @foreach ($group['employers'] as $employer)
            <li>{{ $employer }}</li>
        @endforeach
    </ul>
@endforeach
<hr>

<h2>8. Shortlisted Job Titles</h2>
@foreach ($content['job_titles'] ?? [] as $group)
    <h3>{{ $group['category'] }}</h3>
    <ul>
        @foreach ($group['titles'] as $title)
            <li>{{ $title }}</li>
        @endforeach
    </ul>
@endforeach
<hr>

<h2>9. Final Recommendation</h2>
<p>{{ $content['final_recommendation_intro'] ?? '' }}</p>
<ul>
    @foreach ($programs as $program)
        <li>
            <strong>{{ $program['program'] }}</strong>
            @if (!empty($program['licensing_note']))
                <br><span class="note">{{ $program['licensing_note'] }}</span>
            @endif
        </li>
    @endforeach
</ul>
<hr>

<h2>10. Best Fit Program and Why</h2>
<p><strong>Recommended Program:</strong> {{ $bestFit['program'] ?? '' }}</p>
<h3>Why this program fits you best:</h3>
<ul>
    @foreach ($bestFit['why'] ?? [] as $reason)
        <li><strong>{{ $reason['heading'] }}:</strong> {{ $reason['detail'] }}</li>
    @endforeach
</ul>
<hr>

<h2>11. Conclusion</h2>
@foreach (preg_split('/\n\s*\n/', trim($content['conclusion'] ?? '')) as $paragraph)
    <p>{{ $paragraph }}</p>
@endforeach
<p>Regards,<br>Connected Education Team</p>
</body>
</html>
