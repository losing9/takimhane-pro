<x-app-layout>
    <x-slot name="header">
        <h2 class="font-display font-semibold text-xl text-royal-gold leading-tight">
            {{ __('Alet Yönetimi') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="card">
                <div class="px-6 py-4 border-b border-slate-200 flex flex-col sm:flex-row justify-between items-center bg-slate-50/50 gap-4">
                    <!-- Search -->
                    <form action="{{ route('tools.index') }}" method="GET" class="w-full sm:w-auto">
                        <div class="relative">
                            <i class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-400"></i>
                            <input type="text" name="search" value="{{ request('search') }}" placeholder="Alet ara... (Seri No, Ad, Marka)" 
                                   class="pl-10 pr-4 py-2 border border-slate-300 rounded-lg text-sm focus:ring-brand-500 focus:border-brand-500 w-full sm:w-64 bg-white text-slate-900">
                        </div>
                    </form>

                    <!-- Actions -->
                    <div class="flex gap-2">
                        <a href="{{ route('tools.create') }}" class="btn-primary">
                            <i class="bi bi-plus-lg mr-2"></i> Yeni Alet
                        </a>
                    </div>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Seri No</th>
                                <th class="px-6 py-3 font-semibold">Adı</th>
                                <th class="px-6 py-3 font-semibold">Marka / Model</th>
                                <th class="px-6 py-3 font-semibold">Durum</th>
                                <th class="px-6 py-3 font-semibold">Konum</th>
                                <th class="px-6 py-3 font-semibold text-right">İşlemler</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @forelse($tools as $tool)
                                <tr class="hover:bg-slate-50 transition">
                                    <td class="px-6 py-4 font-mono text-slate-600">{{ $tool->serial_number }}</td>
                                    <td class="px-6 py-4 font-medium text-slate-900">{{ $tool->name }}</td>
                                    <td class="px-6 py-4 text-slate-600">{{ $tool->brand }} {{ $tool->model }}</td>
                                    <td class="px-6 py-4">
                                        @php
                                            $statusColors = [
                                                'active' => 'bg-emerald-100 text-emerald-800',
                                                'maintenance' => 'bg-amber-100 text-amber-800',
                                                'repair' => 'bg-orange-100 text-orange-800',
                                                'lost' => 'bg-red-100 text-red-800',
                                                'scrapped' => 'bg-slate-100 text-slate-800',
                                            ];
                                            $statusLabels = [
                                                'active' => 'Aktif',
                                                'maintenance' => 'Bakımda',
                                                'repair' => 'Tamirde',
                                                'lost' => 'Kayıp',
                                                'scrapped' => 'Hurda',
                                            ];
                                        @endphp
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium {{ $statusColors[$tool->status] ?? 'bg-slate-100 text-slate-800' }}">
                                            {{ $statusLabels[$tool->status] ?? $tool->status }}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-slate-600">
                                        @if($tool->currentLoan)
                                            <span class="text-red-600 font-medium" title="Zimmetli: {{ $tool->currentLoan->personnel->name }}">
                                                <i class="bi bi-person-fill"></i> {{ Str::limit($tool->currentLoan->personnel->name, 15) }}
                                            </span>
                                        @else
                                            <span class="text-emerald-600 font-medium">
                                                <i class="bi bi-box-seam"></i> {{ $tool->shelf ? $tool->shelf->name : ($tool->shelf_location ?? 'Depo') }}
                                            </span>
                                        @endif
                                    </td>
                                    <td class="px-6 py-4 text-right flex justify-end gap-2">
                                        <a href="{{ route('tools.edit', $tool) }}" class="p-1 text-slate-400 hover:text-brand-600 transition" title="Düzenle">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <form action="{{ route('tools.destroy', $tool) }}" method="POST" onsubmit="return confirm('Silmek istediğinize emin misiniz?');">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="p-1 text-slate-400 hover:text-red-600 transition" title="Sil">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="6" class="px-6 py-12 text-center text-slate-400">
                                        <i class="bi bi-tools text-4xl mb-3 block opacity-50"></i>
                                        <span class="block">Kayıtlı alet bulunamadı.</span>
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                
                @if($tools->hasPages())
                    <div class="px-6 py-4 border-t border-slate-200">
                        {{ $tools->links() }}
                    </div>
                @endif
            </div>
        </div>
    </div>
</x-app-layout>
