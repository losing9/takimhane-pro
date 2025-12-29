<x-app-layout>
    <x-slot name="header">
        Tutanak Hazırla: #{{ $maintenance->id }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-4xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                <form action="{{ route('maintenance.report.generate', $maintenance) }}" method="POST">
                    @csrf
                    
                    <div class="mb-6">
                        <x-input-label for="description" value="Arıza / Hasar Tanımı" />
                        <textarea id="description" name="description" rows="4" class="form-input mt-1 block w-full" required>{{ old('description', $maintenance->description) }}</textarea>
                        <x-input-error :messages="$errors->get('description')" class="mt-2" />
                    </div>

                    <div class="mb-6">
                        <x-input-label for="result" value="Tespit ve Sonuç" />
                        <textarea id="result" name="result" rows="4" class="form-input mt-1 block w-full" placeholder="Yapılan inceleme sonucu...">{{ old('result', $maintenance->result) }}</textarea>
                        <p class="text-xs text-slate-500 mt-1">Bu alan tutanak çıktısında "Tespit ve Sonuç" bölümünde görünecektir.</p>
                        <x-input-error :messages="$errors->get('result')" class="mt-2" />
                    </div>

                    <div class="flex justify-end gap-3">
                        <a href="{{ route('maintenance.index') }}" class="btn-secondary">İptal</a>
                        <button type="submit" class="btn-primary">
                            <i class="bi bi-file-earmark-pdf mr-2"></i> Tutanağı Kaydet ve İndir
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
