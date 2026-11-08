{{--
    A titled bullet list that breaks across pages cleanly. Lists of 5 or fewer
    stay whole. Longer ones keep the title (and the section heading, when
    given) with at least half of the points, and keep the last 2 points
    together, so no heading or stray point is left alone on a page.
--}}
@php
    $items = array_values($items);
    $split = count($items) > 5 ? max(3, (int) ceil(count($items) / 2)) : count($items);
    $head = array_slice($items, 0, $split);
    $rest = array_slice($items, $split);
@endphp
<div class="keep">
    @if (!empty($heading))
        <h2>{{ $heading }}</h2>
    @endif
    <h3>{{ $title }}</h3>
    <ul @if ($rest) class="joined" @endif>
        @foreach ($head as $item)
            <li>{{ $item }}</li>
        @endforeach
    </ul>
</div>
@if ($rest)
    <ul>
        @foreach ($rest as $item)
            <li @if ($loop->remaining === 1) class="kn" @endif>{{ $item }}</li>
        @endforeach
    </ul>
@endif
