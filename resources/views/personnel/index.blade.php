<x-app-layout>
    <x-slot name="header">
        {{ __('Personel Yönetimi') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="card">
                <div class="px-6 py-4 border-b border-slate-200 flex flex-col sm:flex-row justify-between items-center bg-slate-50/50 gap-4">
                    <form action="{{ route('personnel.index') }}" method="GET" class="w-full sm:w-auto">
                        <div class="relative">
                            <i class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-400"></i>
                            <input type="text" name="search" value="{{ request('search') }}" placeholder="Personel ara..." 
                                   class="pl-10 pr-4 py-2 border border-slate-300 rounded-lg text-sm focus:ring-brand-500 focus:border-brand-500 w-full sm:w-64 bg-white text-slate-900">
                        </div>
                    </form>

                    <a href="{{ route('personnel.create') }}" class="btn-primary">
                        <i class="bi bi-plus-lg mr-2"></i> Yeni Personel
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Ad Soyad</th>
                                <th class="px-6 py-3 font-semibold">Ünvan</th>
                                <th class="px-6 py-3 font-semibold">Telefon</th>
                                <th class="px-6 py-3 font-semibold text-right">İşlemler</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @foreach($personnel as $p)
                                <tr class="hover:bg-slate-50 transition">
                                    <td class="px-6 py-4 font-medium text-slate-900">{{ $p->name }}</td>
                                    <td class="px-6 py-4 text-slate-600">{{ $p->title }}</td>
                                    <td class="px-6 py-4 text-slate-600 font-mono">{{ $p->phone }}</td>
                                    <td class="px-6 py-4 text-right flex justify-end gap-2">
                                        <a href="{{ route('personnel.edit', $p) }}" class="p-1 text-slate-400 hover:text-brand-600 transition" title="Düzenle">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <form action="{{ route('personnel.destroy', $p) }}" method="POST" onsubmit="return confirm('Silmek istediğinize emin misiniz?');">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="p-1 text-slate-400 hover:text-red-600 transition" title="Sil">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
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
