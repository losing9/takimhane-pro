<x-app-layout>
    <x-slot name="header">
        {{ __('Hasar & Bakım Takibi') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="card">
                <div class="px-6 py-4 border-b border-slate-200 flex flex-col sm:flex-row justify-between items-center bg-slate-50/50 gap-4">
                    <form action="{{ route('maintenance.index') }}" method="GET" class="flex flex-col sm:flex-row gap-2 w-full sm:w-auto">
                        <select name="status" onchange="this.form.submit()" class="pl-3 pr-8 py-2 border border-slate-300 rounded-lg text-sm focus:ring-brand-500 focus:border-brand-500 bg-white text-slate-900 w-full sm:w-48">
                            <option value="">Tümü</option>
                            <option value="pending" {{ request('status') == 'pending' ? 'selected' : '' }}>Bekleyen</option>
                            <option value="in_progress" {{ request('status') == 'in_progress' ? 'selected' : '' }}>İşlemde</option>
                            <option value="completed" {{ request('status') == 'completed' ? 'selected' : '' }}>Tamamlanan</option>
                        </select>
                    </form>

                    <a href="{{ route('maintenance.create') }}" class="btn-primary">
                        <i class="bi bi-exclamation-triangle mr-2"></i> Arıza Bildir
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Alet</th>
                                <th class="px-6 py-3 font-semibold">Açıklama</th>
                                <th class="px-6 py-3 font-semibold">Bildiren</th>
                                <th class="px-6 py-3 font-semibold">Durum</th>
                                <th class="px-6 py-3 font-semibold text-right">İşlemler</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @foreach($maintenances as $m)
                                <tr class="hover:bg-slate-50 transition">
                                    <td class="px-6 py-4">
                                        <div class="font-medium text-slate-900">{{ $m->tool->name }}</div>
                                        <div class="text-xs text-slate-500">{{ $m->tool->serial_number }}</div>
                                    </td>
                                    <td class="px-6 py-4 text-slate-600">{{ Str::limit($m->description, 50) }}</td>
                                    <td class="px-6 py-4 text-slate-600">{{ $m->user->name }}</td>
                                    <td class="px-6 py-4">
                                        @php
                                            $statusClass = match($m->status) {
                                                'pending' => 'bg-red-100 text-red-800',
                                                'in_progress' => 'bg-amber-100 text-amber-800',
                                                'completed' => 'bg-emerald-100 text-emerald-800',
                                                default => 'bg-slate-100 text-slate-800'
                                            };
                                            $statusLabel = match($m->status) {
                                                'pending' => 'Bekliyor',
                                                'in_progress' => 'İşlemde',
                                                'completed' => 'Tamamlandı',
                                                default => $m->status
                                            };
                                        @endphp
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium {{ $statusClass }}">
                                            {{ $statusLabel }}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        @if($m->status !== 'completed' && $m->status !== 'scrapped')
                                            <form action="{{ route('maintenance.update', $m) }}" method="POST" class="inline">
                                                @csrf
                                                @method('PUT')
                                                @if($m->status === 'pending')
                                                    <input type="hidden" name="status" value="in_progress">
                                                    <button class="text-amber-600 hover:text-amber-800 text-sm font-medium transition mr-2">İşleme Al</button>
                                                @else
                                                    <input type="hidden" name="status" value="completed">
                                                    <input type="hidden" name="completed_at" value="{{ now() }}">
                                                    <button class="text-emerald-600 hover:text-emerald-800 text-sm font-medium transition mr-2">Tamamla</button>
                                                @endif
                                            </form>
                                        @else
                                            <span class="text-xs text-slate-400 mr-2">
                                                {{ $m->completed_at ? $m->completed_at->format('d.m.Y') : '-' }}
                                            </span>
                                        @endif
                                        <a href="{{ route('maintenance.report', $m) }}" target="_blank" class="text-slate-500 hover:text-brand-600 font-medium text-sm inline-flex items-center gap-1">
                                            <i class="bi bi-file-earmark-text"></i> Tutanak
                                        </a>
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
