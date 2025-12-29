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
    <body class="font-sans antialiased text-slate-900 bg-slate-50 selection:bg-brand-500 selection:text-white">
        <div class="min-h-screen flex bg-slate-50">
            <!-- Sidebar -->
            <aside class="w-72 bg-slate-900 text-white flex-shrink-0 hidden md:flex flex-col relative overflow-hidden">
                <!-- Sidebar Gradient Background -->
                <div class="absolute inset-0 bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 z-0"></div>
                <div class="absolute top-0 left-0 w-full h-full bg-[url('/img/grid.svg')] opacity-5 z-0"></div>

                <div class="p-6 flex items-center justify-center border-b border-white/10 relative z-10">
                    <div class="flex items-center gap-3">
                        <div class="p-2.5 bg-gradient-to-br from-brand-400 to-brand-600 rounded-xl shadow-lg shadow-brand-500/30 ring-1 ring-white/20">
                            <i class="bi bi-heptagon-half text-xl text-white"></i>
                        </div>
                        <span class="text-xl font-display font-bold tracking-tight text-white">Takımhane<span class="text-brand-400">Pro</span></span>
                    </div>
                </div>

                <nav class="flex-1 px-4 py-8 space-y-2 overflow-y-auto relative z-10 custom-scrollbar">
                    <p class="px-3 text-xs font-bold text-slate-500 uppercase tracking-widest mb-4 ml-1">Ana Menü</p>
                    <a href="{{ route('dashboard') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('dashboard') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-grid-1x2-fill mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('dashboard') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Dashboard
                    </a>
                    <a href="{{ route('tools.index') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('tools.*') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-tools mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('tools.*') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Aletler
                    </a>
                    <a href="{{ route('personnel.index') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('personnel.*') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-people mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('personnel.*') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Personel
                    </a>
                    <a href="{{ route('loans.index') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('loans.*') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-box-arrow-right mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('loans.*') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Zimmet / Ödünç
                    </a>

                    <p class="px-3 text-xs font-bold text-slate-500 uppercase tracking-widest mt-8 mb-4 ml-1">Yönetim</p>
                    <a href="{{ route('shelves.index') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('shelves.*') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-grid-3x3 mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('shelves.*') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Raflar
                    </a>
                    <a href="{{ route('categories.index') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('categories.*') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-tags mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('categories.*') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Kategoriler
                    </a>
                    <a href="{{ route('maintenance.index') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('maintenance.*') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-wrench-adjustable mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('maintenance.*') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Hasar / Bakım
                    </a>
                    <a href="{{ route('calibration.index') }}" class="group flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200 {{ request()->routeIs('calibration.*') ? 'bg-brand-600/90 text-white shadow-lg shadow-brand-900/50 ring-1 ring-white/10' : 'text-slate-400 hover:text-white hover:bg-white/5 hover:translate-x-1' }}">
                        <i class="bi bi-stopwatch mr-3 transition-transform group-hover:scale-110 {{ request()->routeIs('calibration.*') ? 'text-white' : 'text-slate-500 group-hover:text-brand-400' }}"></i>
                        Kalibrasyon
                    </a>
                </nav>

                <div class="p-4 border-t border-white/10 relative z-10 bg-slate-900/50">
                    <div class="flex items-center">
                        <div class="h-10 w-10 rounded-full bg-gradient-to-br from-brand-400 to-brand-600 flex items-center justify-center text-white font-bold ring-2 ring-white/20 shadow-lg">
                            {{ substr(Auth::user()->name, 0, 1) }}
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-semibold text-white">{{ Auth::user()->name }}</p>
                            <p class="text-xs text-brand-200 font-medium">Workshop ID: {{ Auth::user()->workshop_id }}</p>
                        </div>
                    </div>
                </div>
            </aside>

            <!-- Main Content -->
            <div class="flex-1 flex flex-col min-w-0 overflow-hidden bg-slate-50/50">
                <!-- Topbar -->
                <header class="bg-white/80 border-b border-slate-200/60 shadow-sm z-20 backdrop-blur-md sticky top-0">
                    <div class="px-4 sm:px-6 lg:px-8 h-20 flex justify-between items-center">
                        <div class="flex items-center md:hidden">
                            <button class="text-slate-500 hover:text-slate-700">
                                <i class="bi bi-list text-2xl"></i>
                            </button>
                        </div>
                        <div class="flex-1 flex justify-end items-center gap-6">
                            <!-- Search (Placeholder) -->
                            <div class="relative hidden sm:block group">
                                <i class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 group-hover:text-brand-500 transition-colors"></i>
                                <input type="text" placeholder="Hızlı ara..." class="pl-10 pr-4 py-2.5 border border-slate-200 rounded-xl text-sm focus:ring-2 focus:ring-brand-500/20 focus:border-brand-500 w-72 bg-slate-50/50 text-slate-900 placeholder-slate-400 transition-all shadow-sm focus:bg-white">
                            </div>

                            <!-- Notifications -->
                            <button class="relative p-2.5 text-slate-400 hover:text-brand-600 transition bg-slate-50 hover:bg-brand-50 rounded-xl border border-transparent hover:border-brand-100">
                                <i class="bi bi-bell text-xl"></i>
                                <span class="absolute top-2.5 right-2.5 h-2 w-2 bg-red-500 rounded-full ring-2 ring-white"></span>
                            </button>

                            <!-- Profile Dropdown -->
                            <div class="relative" x-data="{ open: false }">
                                <button @click="open = ! open" class="flex items-center gap-3 focus:outline-none p-1.5 rounded-xl hover:bg-slate-100 transition">
                                    <div class="h-9 w-9 rounded-full bg-brand-50 text-brand-600 flex items-center justify-center font-bold border border-brand-200 shadow-sm">
                                        {{ substr(Auth::user()->name, 0, 1) }}
                                    </div>
                                    <span class="hidden md:block text-sm font-semibold text-slate-700">{{ Auth::user()->name }}</span>
                                    <i class="bi bi-chevron-down text-xs text-slate-400"></i>
                                </button>

                                <div x-show="open" @click.away="open = false" 
                                     x-transition:enter="transition ease-out duration-100"
                                     x-transition:enter-start="transform opacity-0 scale-95"
                                     x-transition:enter-end="transform opacity-100 scale-100"
                                     x-transition:leave="transition ease-in duration-75"
                                     x-transition:leave-start="transform opacity-100 scale-100"
                                     x-transition:leave-end="transform opacity-0 scale-95"
                                     class="absolute right-0 mt-2 w-56 bg-white rounded-xl shadow-glass border border-slate-100 py-2 z-50 origin-top-right divide-y divide-slate-100" style="display: none;">
                                    
                                    <div class="px-4 py-3">
                                        <p class="text-sm font-semibold text-slate-900">{{ Auth::user()->name }}</p>
                                        <p class="text-xs text-slate-500 truncate mt-0.5">{{ Auth::user()->email }}</p>
                                    </div>

                                    <div class="py-1">
                                        <a href="{{ route('profile.edit') }}" class="flex items-center px-4 py-2 text-sm text-slate-700 hover:bg-slate-50 hover:text-brand-600">
                                            <i class="bi bi-person-gear mr-2"></i> Profil Ayarları
                                        </a>
                                    </div>

                                    <div class="py-1">
                                        <form method="POST" action="{{ route('logout') }}">
                                            @csrf
                                            <button type="submit" class="flex w-full items-center px-4 py-2 text-sm text-slate-700 hover:bg-red-50 hover:text-red-600">
                                                <i class="bi bi-box-arrow-right mr-2"></i> Çıkış Yap
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </header>

                <!-- Page Content -->
                <main class="flex-1 overflow-y-auto p-4 sm:p-8 space-y-8">
                    @if (isset($header))
                        <header>
                            <h1 class="text-3xl font-display font-bold text-slate-900 tracking-tight">
                                {{ $header }}
                            </h1>
                        </header>
                    @endif

                    @if (session('success'))
                        <div class="mb-6 bg-emerald-50 border border-emerald-200 text-emerald-800 px-4 py-4 rounded-xl flex items-center shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill text-xl mr-3 text-emerald-500"></i>
                            <span class="font-medium">{{ session('success') }}</span>
                        </div>
                    @endif

                    {{ $slot }}
                </main>
            </div>
        </div>
        
        @include('partials.ai-widget')
    </body>
</html>
