<x-app-layout>
    <x-slot name="header">
        {{ __('Arıza / Hasar Bildirimi') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                
                <form action="{{ route('maintenance.store') }}" method="POST" class="space-y-6">
                    @csrf

                    <div>
                        <x-input-label for="tool_id" :value="__('Arızalı Alet')" />
                        <select name="tool_id" id="tool_id" class="block mt-1 w-full bg-white border-slate-300 rounded-lg shadow-sm focus:border-brand-500 focus:ring focus:ring-brand-500/50 text-slate-900" required>
                            <option value="">Alet Seçiniz...</option>
                            @foreach($tools as $tool)
                                <option value="{{ $tool->id }}">{{ $tool->name }} - {{ $tool->serial_number }}</option>
                            @endforeach
                        </select>
                    </div>

                    <div>
                        <x-input-label for="description" :value="__('Arıza Açıklaması')" />
                        <textarea name="description" id="description" rows="4" class="block mt-1 w-full bg-white border-slate-300 rounded-lg shadow-sm focus:border-brand-500 focus:ring focus:ring-brand-500/50 text-slate-900 placeholder-slate-400" required></textarea>
                    </div>

                    <div>
                        <x-input-label for="repair_company" :value="__('Servis Firması (Opsiyonel)')" />
                        <x-text-input id="repair_company" class="block mt-1 w-full" 
                                      type="text" name="repair_company" />
                    </div>

                    <div class="flex items-center justify-end mt-4">
                        <a href="{{ route('maintenance.index') }}" class="text-sm text-slate-500 hover:text-slate-700 mr-4">İptal</a>
                        <x-primary-button class="bg-red-600 hover:bg-red-700 text-white">
                            {{ __('Arıza Kaydı Oluştur') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
