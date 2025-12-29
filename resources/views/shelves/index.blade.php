<x-app-layout>
    <x-slot name="header">
        {{ __('Raf ve Konum Yönetimi') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                
                <!-- Left: Create Form -->
                <div class="card p-6 h-fit">
                    <h3 class="text-lg font-bold text-slate-900 mb-4">Yeni Raf Ekle</h3>
                    <form action="{{ route('shelves.store') }}" method="POST" class="space-y-4">
                        @csrf
                        <div>
                            <x-input-label for="name" value="Raf Adı / No" />
                            <x-text-input id="name" name="name" class="w-full mt-1" placeholder="Örn: Raf A1" required/>
                        </div>
                        <div>
                            <x-input-label for="location" value="Konum / Açıklama" />
                            <x-text-input id="location" name="location" class="w-full mt-1" placeholder="Örn: Depo Girişi Sağ"/>
                        </div>
                        <x-primary-button class="w-full justify-center">
                            Ekle
                        </x-primary-button>
                    </form>
                </div>

                <!-- Right: List -->
                <div class="md:col-span-2 card p-6">
                    <h3 class="text-lg font-bold text-slate-900 mb-4">Mevcut Raflar</h3>
                    <div class="grid grid-cols-2 sm:grid-cols-3 gap-4">
                        @foreach($shelves as $shelf)
                        <a href="{{ route('shelves.show', $shelf) }}" class="block p-4 bg-white border border-slate-200 rounded-lg hover:border-brand-500 hover:shadow-md transition group">
                            <div class="font-bold text-lg text-slate-900 group-hover:text-brand-600">{{ $shelf->name }}</div>
                            <div class="text-xs text-slate-500">{{ $shelf->location }}</div>
                            <div class="mt-2 text-right">
                                <span class="text-xs bg-slate-100 text-slate-600 px-2 py-1 rounded-full">{{ $shelf->tools_count }} Alet</span>
                            </div>
                        </a>
                        @endforeach
                    </div>
                </div>

            </div>
        </div>
    </div>
</x-app-layout>
