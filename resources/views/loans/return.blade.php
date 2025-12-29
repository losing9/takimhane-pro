<x-app-layout>
    <x-slot name="header">
        {{ __('Alet İadesi Al') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-bold mb-4">İade İşlemi</h3>
                    
                    <div class="mb-4 p-4 bg-slate-50 rounded-lg border border-slate-100">
                        <p class="text-sm text-slate-500">Alet:</p>
                        <p class="font-bold text-lg">{{ $loan->tool->name }}</p>
                        <p class="text-xs font-mono text-slate-400">{{ $loan->tool->serial_number }}</p>
                        
                        <div class="mt-2 pt-2 border-t border-slate-200">
                            <p class="text-sm text-slate-500">Zimmetlenen Personel:</p>
                            <p class="font-medium">{{ $loan->personnel->name }}</p>
                            <p class="text-xs text-slate-400">Veriliş Tarihi: {{ $loan->created_at->format('d.m.Y H:i') }}</p>
                        </div>
                    </div>

                    <form action="{{ route('loans.update', $loan) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <input type="hidden" name="return_action" value="1">
                        
                        <div class="mb-4">
                            <x-input-label for="notes" :value="__('İade Notları / Durum Kontrolü')" />
                            <textarea name="notes" id="notes" rows="3" class="block w-full border-gray-300 rounded-md shadow-sm focus:border-brand-500 focus:ring focus:ring-brand-500/50 mt-1" placeholder="Aletin durumu, hasar var mı?"></textarea>
                        </div>

                        <div class="flex justify-end gap-3">
                            <a href="{{ route('dashboard') }}" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition">İptal</a>
                            <button type="submit" class="px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition shadow-lg">
                                İade Al ve Kapat
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
