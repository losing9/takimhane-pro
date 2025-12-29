<x-app-layout>
    <x-slot name="header">
        {{ __('Zimmet / Emanet Takibi') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="card">
                <div class="px-6 py-4 border-b border-slate-200 flex flex-col sm:flex-row justify-between items-center bg-slate-50/50 gap-4">
                    <!-- Search & Filter -->
                    <form action="{{ route('loans.index') }}" method="GET" class="flex flex-col sm:flex-row gap-2 w-full sm:w-auto">
                        <div class="relative">
                            <i class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-400"></i>
                            <input type="text" name="search" value="{{ request('search') }}" placeholder="Alet veya Personel ara..." 
                                   class="pl-10 pr-4 py-2 border border-slate-300 rounded-lg text-sm focus:ring-brand-500 focus:border-brand-500 w-full sm:w-64 bg-white text-slate-900">
                        </div>
                        <select name="status" onchange="this.form.submit()" class="pl-3 pr-8 py-2 border border-slate-300 rounded-lg text-sm focus:ring-brand-500 focus:border-brand-500 bg-white text-slate-900">
                            <option value="">Tümü</option>
                            <option value="open" {{ request('status') == 'open' ? 'selected' : '' }}>Zimmetli (Dışarıda)</option>
                            <option value="closed" {{ request('status') == 'closed' ? 'selected' : '' }}>İade Edilmiş</option>
                        </select>
                    </form>

                    <a href="{{ route('loans.create') }}" class="btn-primary">
                        <i class="bi bi-box-arrow-right mr-2"></i> Alet Ver
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Alet</th>
                                <th class="px-6 py-3 font-semibold">Personel</th>
                                <th class="px-6 py-3 font-semibold">Veriliş Tarihi</th>
                                <th class="px-6 py-3 font-semibold">Durum</th>
                                <th class="px-6 py-3 font-semibold text-right">İşlemler</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @foreach($loans as $loan)
                                <tr class="hover:bg-slate-50 transition">
                                    <td class="px-6 py-4">
                                        <div class="font-medium text-slate-900">{{ $loan->tool->name }}</div>
                                        <div class="text-xs text-slate-500 font-mono">{{ $loan->tool->serial_number }}</div>
                                    </td>
                                    <td class="px-6 py-4 text-slate-700">{{ $loan->personnel->name }}</td>
                                    <td class="px-6 py-4 text-slate-600">
                                        <div class="text-slate-900">{{ $loan->issued_at }}</div>
                                        <div class="text-xs text-slate-400">Veren: {{ $loan->user->name }}</div>
                                    </td>
                                    <td class="px-6 py-4">
                                        @if($loan->returned_at)
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                İADE EDİLDİ
                                            </span>
                                            <div class="text-xs text-slate-400 mt-1">{{ $loan->returned_at }}</div>
                                        @else
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">
                                                ZİMMETLİ
                                            </span>
                                        @endif
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        @if(!$loan->returned_at)
                                            <form action="{{ route('loans.update', $loan) }}" method="POST" class="inline">
                                                @csrf
                                                @method('PUT')
                                                <input type="hidden" name="return_action" value="1">
                                                <button type="submit" class="inline-flex items-center px-3 py-1 bg-white border border-slate-300 rounded-lg text-xs font-semibold text-slate-700 hover:bg-slate-50 hover:text-brand-600 transition shadow-sm" title="İade Al">
                                                    <i class="bi bi-arrow-return-left mr-1"></i> İade Al
                                                </button>
                                            </form>
                                        @endif
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                
                <div class="px-6 py-4 border-t border-slate-200">
                    {{ $loans->links() }}
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
