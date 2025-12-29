<x-app-layout>
    <x-slot name="header">
        {{ isset($personnel) ? 'Personel Düzenle' : 'Yeni Personel Ekle' }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                
                <form action="{{ isset($personnel) ? route('personnel.update', $personnel) : route('personnel.store') }}" method="POST" class="space-y-6">
                    @csrf
                    @if(isset($personnel))
                        @method('PUT')
                    @endif

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Sicil No (Autofocus for QR) -->
                        <div class="md:col-span-2">
                            <x-input-label for="personnel_id" :value="__('Sicil No / Personel ID')" class="text-brand-600 font-bold" />
                            <div class="mt-1 relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="bi bi-qr-code-scan text-slate-400"></i>
                                </div>
                                <input type="text" name="personnel_id" id="personnel_id" 
                                       class="block w-full pl-10 border-slate-300 rounded-lg focus:ring-brand-500 focus:border-brand-500 text-lg font-mono bg-indigo-50/50" 
                                       placeholder="Barkod okutunuz..." 
                                       value="{{ old('personnel_id', $personnel->personnel_id ?? '') }}" 
                                       required autofocus>
                            </div>
                            <x-input-error :messages="$errors->get('personnel_id')" class="mt-2" />
                        </div>

                        <!-- Name -->
                        <div>
                            <x-input-label for="name" :value="__('Ad')" />
                            <x-text-input id="name" class="block mt-1 w-full" type="text" name="name" :value="old('name', $personnel->name ?? '')" required />
                            <x-input-error :messages="$errors->get('name')" class="mt-2" />
                        </div>

                        <!-- Surname -->
                        <div>
                            <x-input-label for="surname" :value="__('Soyad')" />
                            <x-text-input id="surname" class="block mt-1 w-full" type="text" name="surname" :value="old('surname', $personnel->surname ?? '')" required />
                            <x-input-error :messages="$errors->get('surname')" class="mt-2" />
                        </div>

                        <!-- Title -->
                        <div>
                            <x-input-label for="title" :value="__('Ünvan / Bölüm')" />
                            <x-text-input id="title" class="block mt-1 w-full" type="text" name="title" :value="old('title', $personnel->title ?? '')" placeholder="Örn: Teknisyen" />
                        </div>

                        <!-- Phone -->
                        <div>
                            <x-input-label for="phone" :value="__('Telefon')" />
                            <x-text-input id="phone" class="block mt-1 w-full font-mono" type="text" name="phone" :value="old('phone', $personnel->phone ?? '')" placeholder="5XX..." />
                        </div>
                    </div>

                    <!-- Email (Optional) -->
                    <div>
                        <x-input-label for="email" :value="__('Email (Opsiyonel)')" />
                        <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email', $personnel->email ?? '')" />
                    </div>

                    <div class="flex items-center justify-between mt-8 pt-6 border-t border-slate-100">
                        <a href="{{ route('personnel.index') }}" class="text-sm text-slate-500 hover:text-slate-700">İptal</a>
                        <div class="flex gap-3">
                            @if(!isset($personnel))
                                <button type="submit" name="save_and_new" value="1" class="bg-white border border-slate-300 text-slate-700 hover:bg-slate-50 font-bold py-2 px-4 rounded-lg shadow-sm transition">
                                    <i class="bi bi-plus-lg mr-1"></i> Kaydet ve Yeni Ekle
                                </button>
                            @endif
                            <x-primary-button>
                                <i class="bi bi-check-lg mr-1"></i> {{ isset($personnel) ? __('Güncelle') : __('Kaydet') }}
                            </x-primary-button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
