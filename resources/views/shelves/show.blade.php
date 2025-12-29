<x-app-layout>
    <x-slot name="header">
        {{ __('Raf İçeriği: ') . $shelf->name }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                <div class="mb-6 flex justify-between items-center">
                    <h3 class="text-lg font-bold text-slate-800">Alet Listesi</h3>
                    <a href="{{ route('shelves.index') }}" class="text-sm text-slate-500 hover:text-brand-600 transition flex items-center">
                        <i class="bi bi-arrow-left mr-1"></i> Raflara Dön
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Seri No</th>
                                <th class="px-6 py-3 font-semibold">Alet Adı</th>
                                <th class="px-6 py-3 font-semibold">Marka</th>
                                <th class="px-6 py-3 font-semibold">Durum</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @foreach($tools as $tool)
                            <tr class="hover:bg-slate-50 transition">
                                <td class="px-6 py-4 font-mono text-slate-600">{{ $tool->serial_number }}</td>
                                <td class="px-6 py-4 font-medium text-slate-900">{{ $tool->name }}</td>
                                <td class="px-6 py-4 text-slate-600">{{ $tool->brand }}</td>
                                <td class="px-6 py-4 text-slate-600">{{ $tool->status }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <div class="mt-4 px-6">
                    {{ $tools->links() }}
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
