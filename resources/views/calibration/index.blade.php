<x-app-layout>
    <x-slot name="header">
        {{ __('Kalibrasyon Takibi') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            
            <div class="flex justify-end mb-4">
            <div class="flex justify-end mb-4">
                <a href="{{ route('calibration.create') }}" class="btn-primary">
                    <i class="bi bi-plus-lg mr-2"></i> Yeni Kalibrasyon Kaydı
                </a>
            </div>

            <!-- Upcoming -->
            <div class="card mb-8">
                <div class="px-6 py-4 border-b border-slate-200 bg-slate-50/50">
                    <h3 class="text-lg font-bold text-slate-800">Gelecek Kalibrasyonlar</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Alet</th>
                                <th class="px-6 py-3 font-semibold">Son Kalibrasyon</th>
                                <th class="px-6 py-3 font-semibold">Bitiş Tarihi</th>
                                <th class="px-6 py-3 font-semibold">Durum</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @foreach($upcoming as $c)
                            <tr class="hover:bg-slate-50 transition">
                                <td class="px-6 py-4 font-medium text-slate-900">
                                    {{ $c->tool->name }} 
                                    <span class="text-xs text-slate-500 block font-normal">{{ $c->tool->serial_number }}</span>
                                </td>
                                <td class="px-6 py-4 text-slate-600">{{ $c->calibration_date->format('d.m.Y') }}</td>
                                <td class="px-6 py-4 font-bold {{ $c->next_calibration_date < now()->addDays(7) ? 'text-red-600' : 'text-emerald-600' }}">
                                    {{ $c->next_calibration_date->format('d.m.Y') }}
                                </td>
                                <td class="px-6 py-4">
                                    <span class="text-xs bg-slate-100 text-slate-600 px-2 py-1 rounded-full">{{ $c->company ?? 'Belirtilmedi' }}</span>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- History -->
            <div class="card opacity-75 hover:opacity-100 transition">
                <div class="px-6 py-4 border-b border-slate-200 bg-slate-50/50">
                    <h3 class="text-lg font-bold text-slate-600">Geçmiş Kayıtlar</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Alet</th>
                                <th class="px-6 py-3 font-semibold">Tarih</th>
                                <th class="px-6 py-3 font-semibold">Sertifika No</th>
                                <th class="px-6 py-3 font-semibold">Sonuç</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @foreach($history as $h)
                            <tr class="hover:bg-slate-50 transition">
                                <td class="px-6 py-4 text-slate-900">{{ $h->tool->name }}</td>
                                <td class="px-6 py-4 text-slate-600">{{ $h->calibration_date->format('d.m.Y') }}</td>
                                <td class="px-6 py-4 text-slate-600 font-mono">{{ $h->certificate_no }}</td>
                                <td class="px-6 py-4">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold {{ $h->status == 'pass' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800' }}">
                                        {{ $h->status == 'pass' ? 'GEÇTİ' : 'KALDI' }}
                                    </span>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</x-app-layout>
