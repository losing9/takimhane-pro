<x-app-layout>
    <x-slot name="header">
        {{ __('Yeni Kalibrasyon Kaydı') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                
                <form action="{{ route('calibration.store') }}" method="POST" class="space-y-6">
                    @csrf

                    <div>
                        <x-input-label for="tool_id" :value="__('Alet')" />
                        <select name="tool_id" id="tool_id" class="block mt-1 w-full bg-white border-slate-300 rounded-lg shadow-sm focus:border-brand-500 focus:ring focus:ring-brand-500/50 text-slate-900" required>
                            @foreach($tools as $tool)
                                <option value="{{ $tool->id }}">{{ $tool->name }} ({{ $tool->serial_number }})</option>
                            @endforeach
                        </select>
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <x-input-label for="calibration_date" :value="__('Yapıldığı Tarih')" />
                            <x-text-input id="calibration_date" type="date" name="calibration_date" class="block mt-1 w-full" required />
                        </div>
                        <div>
                            <x-input-label for="next_calibration_date" :value="__('Geçerlilik Tarihi (Sonraki)')" />
                            <x-text-input id="next_calibration_date" type="date" name="next_calibration_date" class="block mt-1 w-full" required />
                        </div>
                    </div>

                    <div>
                        <x-input-label for="company" :value="__('Yapan Firma')" />
                        <x-text-input id="company" type="text" name="company" class="block mt-1 w-full" />
                    </div>

                    <div>
                        <x-input-label for="certificate_no" :value="__('Sertifika No')" />
                        <x-text-input id="certificate_no" type="text" name="certificate_no" class="block mt-1 w-full" />
                    </div>

                    <div>
                        <x-input-label for="status" :value="__('Sonuç')" />
                        <select name="status" class="block mt-1 w-full bg-white border-slate-300 rounded-lg shadow-sm focus:border-brand-500 focus:ring focus:ring-brand-500/50 text-slate-900">
                            <option value="pass">BAŞARILI (GEÇTİ)</option>
                            <option value="fail">BAŞARISIZ (KALDI)</option>
                        </select>
                    </div>

                    <div class="flex items-center justify-end mt-4">
                        <a href="{{ route('calibration.index') }}" class="text-sm text-slate-500 hover:text-slate-700 mr-4">İptal</a>
                        <x-primary-button>
                            {{ __('Kaydet') }}
                        </x-primary-button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
