<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Personality labels (report Section 3)
    |--------------------------------------------------------------------------
    | Section 3 is built by code from these fixed labels, never by the AI, so a
    | student's answer cannot change meaning. Keys are question titles in
    | lowercase with only letters and digits; "first"/"second" are the option
    | the student picked. A question missing here prints the student's own words.
    */
    'personality_labels' => [
        'highsalaryimportance' => [
            'area' => 'High Salary Importance',
            'first' => 'Highly money motivated',
            'second' => 'Happy with an average income if happy in the job',
        ],
        'jobsecurity' => [
            'area' => 'Job Security',
            'first' => 'Prefers a stable and predictable career path',
            'second' => 'Likes taking risks and prefers rapid career advancement',
        ],
        'worklifebalance' => [
            'area' => 'Work-Life Balance',
            'first' => 'Enjoys working all the time',
            'second' => 'Prefers a balanced life, home after working hours',
        ],
        'travelwillingness' => [
            'area' => 'Travel Willingness',
            'first' => 'Does not mind being away from family from time to time',
            'second' => 'Prefers always staying close to family',
        ],
        'teamworkpreference' => [
            'area' => 'Teamwork Preference',
            'first' => 'Loves being around people and working together',
            'second' => 'Prefers to work alone independently',
        ],
        'socialinteractivity' => [
            'area' => 'Social Interactivity',
            'first' => 'Loves talking to strangers and speaking publicly',
            'second' => 'Does not enjoy lots of public interaction',
        ],
        'workenvironmentpressure' => [
            'area' => 'Work Environment Pressure',
            'first' => 'Enjoys high-pressure work environments',
            'second' => 'Prefers a balanced work-pressure environment',
        ],
        'physicalactivity' => [
            'area' => 'Physical Activity',
            'first' => 'Likes moving around a lot and being in the field',
            'second' => 'Prefers a job with less physical activity',
        ],
        'outdoorwork' => [
            'area' => 'Outdoor Work',
            'first' => 'Loves being outdoors all the time; does not like being confined to an office',
            'second' => 'Prefers an office environment with a predictable day',
        ],
        'recognition' => [
            'area' => 'Recognition',
            'first' => 'Loves being recognized publicly',
            'second' => 'Prefers being appreciated privately',
        ],
        'leadershipandinfluence' => [
            'area' => 'Leadership & Influence',
            'first' => 'Loves leading and influencing people',
            'second' => 'Feels very anxious leading people',
        ],
        'ambitioncompetitiveness' => [
            'area' => 'Ambition & Competitiveness',
            'first' => 'Likes to compete and achieve top positions',
            'second' => 'Prefers equal treatment and collaboration over competition',
        ],
        'decisionmaking' => [
            'area' => 'Decision-Making',
            'first' => 'Enjoys making significant decisions',
            'second' => 'Prefers following established guidelines from an expert',
        ],
        'technicalvsnontechnical' => [
            'area' => 'Technical vs Non-Technical',
            'first' => 'Enjoys technical roles requiring specialized skills',
            'second' => 'Prefers non-technical roles requiring broad skill sets',
        ],
        'conflictresolution' => [
            'area' => 'Conflict Resolution',
            'first' => 'Enjoys conflict resolution and negotiation',
            'second' => 'Prefers roles with minimal conflict',
        ],
    ],

    // Ordered from strongest to weakest. The validator uses this order.
    'match_levels' => ['Very High', 'High', 'Moderate to High', 'Moderate', 'Low to Moderate', 'Low'],

    // Match comments and best-fit reasons must fit about three lines of the PDF table.
    'comment_max_characters' => 130,

    // Prices are US dollars per 1M tokens from OpenAI's pricing page (November 2026).
    // They only feed the cost hint in AI Settings.
    'ai_models' => [
        ['id' => 'gpt-6-astra', 'label' => 'GPT-6 Astra (flagship)', 'input_price' => 10, 'output_price' => 50, 'supports_none' => false],
        ['id' => 'gpt-6.1-sol', 'label' => 'GPT-6.1 Sol', 'input_price' => 2, 'output_price' => 10, 'supports_none' => false],
        ['id' => 'gpt-6-sol', 'label' => 'GPT-6 Sol', 'input_price' => 2, 'output_price' => 10, 'supports_none' => false],
        ['id' => 'gpt-6.1-terra', 'label' => 'GPT-6.1 Terra', 'input_price' => 1, 'output_price' => 5, 'supports_none' => true],
        ['id' => 'gpt-6-luna', 'label' => 'GPT-6 Luna (lowest cost)', 'input_price' => 0.1, 'output_price' => 0.5, 'supports_none' => true],
    ],

    'ai_efforts' => ['none', 'low', 'medium', 'high', 'xhigh', 'max'],

    'education_levels' => [
        'SSC / O Level',
        'HSC / A Level',
        'Diploma',
        "Bachelor's Degree",
        "Master's Degree",
    ],

    'study_levels' => ['Undergraduate', 'Postgraduate'],

    'target_countries' => [
        'United Kingdom',
        'Australia',
        'New Zealand',
        'Canada',
        'United States',
        'Ireland',
    ],

    // Validation failures are sent back to the AI this many times before the
    // draft is saved with its problems listed for the counsellor.
    'repair_attempts' => 1,
];
