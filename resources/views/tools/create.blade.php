<x-app-layout>
    <x-slot name="header">
        {{ isset($tool) ? 'Alet Düzenle: ' . $tool->name : 'Yeni Alet Ekle' }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                
                <form action="{{ isset($tool) ? route('tools.update', $tool) : route('tools.store') }}" method="POST" class="space-y-6">
                    @csrf
                    @if(isset($tool))
                        @method('PUT')
                    @endif

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Barcode/Scanning Area -->
                        <div class="md:col-span-2 bg-indigo-50 p-4 rounded-xl border border-indigo-100">
                            <div class="flex items-center justify-between mb-2">
                                <x-input-label for="serial_number" :value="__('Barkod / Seri No')" class="text-brand-700 font-bold text-lg" />
                                <span class="bg-brand-100 text-brand-700 text-xs font-bold px-2 py-1 rounded-full uppercase tracking-wide">Scan Mode</span>
                            </div>
                            
                            <div class="relative rounded-md shadow-sm">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <i class="bi bi-upc-scan text-brand-500 text-xl"></i>
                                </div>
                                <input type="text" name="serial_number" id="serial_number" 
                                       class="block w-full pl-10 border-brand-300 rounded-lg focus:ring-brand-500 focus:border-brand-500 text-xl font-mono py-3" 
                                       placeholder="Barkod okutunuz..." 
                                       value="{{ old('serial_number', $tool->serial_number ?? '') }}" 
                                       required autofocus>
                            </div>
                             <p class="text-xs text-brand-600 mt-2">Okuyucu otomatik enter yaparsa kayıt bir sonraki alana geçer.</p>
                            <x-input-error :messages="$errors->get('serial_number')" class="mt-2" />
                        </div>

                        <!-- Name -->
                        <div class="md:col-span-2">
                            <x-input-label for="name" :value="__('Alet Adı')" />
                            <x-text-input id="name" class="block mt-1 w-full text-lg" 
                                          type="text" name="name" :value="old('name', $tool->name ?? '')" required placeholder="Örn: Matkap Bosch GSB 18" />
                            <x-input-error :messages="$errors->get('name')" class="mt-2" />
                        </div>

                        <!-- Brand & Model -->
                        <div>
                            <x-input-label for="brand" :value="__('Marka')" />
                            <x-text-input id="brand" class="block mt-1 w-full" 
                                          type="text" name="brand" :value="old('brand', $tool->brand ?? '')" placeholder="Bosch" />
                        </div>
                        <div>
                            <x-input-label for="model" :value="__('Model')" />
                            <x-text-input id="model" class="block mt-1 w-full" 
                                          type="text" name="model" :value="old('model', $tool->model ?? '')" placeholder="GSB 180-LI" />
                        </div>
                    </div>

                    <!-- Status -->
                    <div>
                        <x-input-label for="status" :value="__('Durum')" />
                        <select name="status" id="status" class="block mt-1 w-full bg-white border-slate-300 rounded-lg shadow-sm focus:border-brand-500 focus:ring focus:ring-brand-500/50 text-slate-900">
                            <option value="active" {{ (old('status', $tool->status ?? '') == 'active') ? 'selected' : '' }}>Aktif (Kullanılabilir)</option>
                            <option value="maintenance" {{ (old('status', $tool->status ?? '') == 'maintenance') ? 'selected' : '' }}>Bakımda</option>
                            <option value="repair" {{ (old('status', $tool->status ?? '') == 'repair') ? 'selected' : '' }}>Tamirde</option>
                            <option value="lost" {{ (old('status', $tool->status ?? '') == 'lost') ? 'selected' : '' }}>Kayıp</option>
                            <option value="scrapped" {{ (old('status', $tool->status ?? '') == 'scrapped') ? 'selected' : '' }}>Hurda</option>
                        </select>
                        <x-input-error :messages="$errors->get('status')" class="mt-2" />
                    </div>

                    <div class="flex items-center justify-between mt-8 pt-6 border-t border-slate-100">
                        <a href="{{ route('tools.index') }}" class="text-sm text-slate-500 hover:text-slate-700">İptal</a>
                        <div class="flex gap-3">
                            @if(!isset($tool))
                                <button type="submit" name="save_and_new" value="1" class="bg-white border border-slate-300 text-slate-700 hover:bg-slate-50 font-bold py-2 px-4 rounded-lg shadow-sm transition">
                                    <i class="bi bi-plus-lg mr-1"></i> Kaydet ve Yeni Ekle
                                </button>
                            @endif
                            <x-primary-button>
                                <i class="bi bi-check-lg mr-1"></i> {{ isset($tool) ? __('Güncelle') : __('Kaydet') }}
                            </x-primary-button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function generateSerial() {
            const date = new Date();
            const random = Math.floor(Math.random() * 10000);
            const serial = 'TS-' + date.getFullYear() + '-' + random;
            document.getElementById('serial_number').value = serial;
        }
    </script>
</x-app-layout>
