<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="dark">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

        <!-- Scripts -->
        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <body class="font-sans text-gray-200 antialiased bg-gothic-900 bg-royal-gradient min-h-screen flex flex-col items-center justify-center">
        <div class="w-full sm:max-w-md mt-6 px-6 py-8 bg-gothic-800 border border-royal-gold/30 shadow-[0_0_50px_rgba(212,175,55,0.1)] overflow-hidden sm:rounded-lg">
            <div class="flex justify-center mb-8">
                <span class="text-4xl font-gothic text-royal-gold tracking-widest drop-shadow-lg">Takımhane</span>
            </div>
            {{ $slot }}
        </div>
        
        <div class="mt-8 text-gothic-500 font-serif text-sm">
            &copy; {{ date('Y') }} Royal Dominion Systems
        </div>
    </body>
</html>
