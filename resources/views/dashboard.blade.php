<x-app-layout>
    <x-slot name="header">
        {{ __('Dashboard') }}
    </x-slot>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- Stat Card 1 -->
        <div class="card p-6 flex items-center">
            <div class="p-3 rounded-xl bg-brand-50 text-brand-600">
                <i class="bi bi-tools text-3xl"></i>
            </div>
            <div class="ml-4">
                <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Toplam Alet</p>
                <p class="text-2xl font-display text-slate-900 font-bold">{{ $totalTools }}</p>
            </div>
        </div>

        <!-- Stat Card 2 -->
        <div class="card p-6 flex items-center">
             <div class="p-3 rounded-xl bg-red-50 text-red-600">
                <i class="bi bi-box-arrow-right text-3xl"></i>
            </div>
            <div class="ml-4">
                <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Dışarıda</p>
                <p class="text-2xl font-display text-slate-900 font-bold">{{ $loansOut }}</p>
            </div>
        </div>

        <!-- Stat Card 3 -->
        <div class="card p-6 flex items-center">
             <div class="p-3 rounded-xl bg-amber-50 text-amber-600">
                <i class="bi bi-exclamation-triangle text-3xl"></i>
            </div>
            <div class="ml-4">
                <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Gecikmiş</p>
                <p class="text-2xl font-display text-slate-900 font-bold">{{ $overdue }}</p>
            </div>
        </div>
        
         <!-- Stat Card 4 -->
         <div class="card p-6 flex items-center">
             <div class="p-3 rounded-xl bg-emerald-50 text-emerald-600">
                <i class="bi bi-people text-3xl"></i>
            </div>
            <div class="ml-4">
                <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider">Personel</p>
                <p class="text-2xl font-display text-slate-900 font-bold">{{ $totalPersonnel }}</p>
            </div>
        </div>
    </div>

    <!-- Recent Activity Table -->
    <div class="card" x-data="{ 
        toolModalOpen: false, 
        selectedTool: null,
        openToolModal(tool, personnel, loan) {
            this.selectedTool = { ...tool, current_personnel: personnel, loan_info: loan };
            this.toolModalOpen = true;
        }
    }">
        <div class="px-6 py-4 border-b border-slate-200 flex justify-between items-center bg-slate-50/50">
            <h3 class="text-lg font-display font-semibold text-slate-800">Son Hareketler</h3>
            <button class="text-xs font-medium text-brand-600 hover:text-brand-800 transition">Tümünü Gör</button>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-left">
                <thead>
                    <tr class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                        <th class="px-6 py-3 font-semibold">Alet</th>
                        <th class="px-6 py-3 font-semibold">Personel</th>
                        <th class="px-6 py-3 font-semibold">İşlem</th>
                        <th class="px-6 py-3 font-semibold">Tarih</th>
                        <th class="px-6 py-3 font-semibold">Durum</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-200 text-sm">
                    @foreach($recentLoans as $loan)
                        <tr class="hover:bg-slate-50 transition">
                            <td class="px-6 py-4 font-medium text-slate-900">
                                <button @click="openToolModal({{ $loan->tool }}, {{ $loan->personnel ?? 'null' }}, {{ $loan }})" class="text-brand-600 hover:underline hover:text-brand-800 font-bold focus:outline-none">
                                    {{ $loan->tool->name ?? 'Silinmiş Alet' }}
                                </button>
                                <div class="text-xs text-slate-400">{{ $loan->tool->serial_number ?? '' }}</div>
                            </td>
                            <td class="px-6 py-4 text-slate-600">{{ $loan->personnel->name ?? 'Silinmiş Personel' }}</td>
                            <td class="px-6 py-4">
                                @if($loan->returned_at)
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-100 text-emerald-800">
                                        İade Alındı
                                    </span>
                                @else
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-brand-100 text-brand-800">
                                        Verildi
                                    </span>
                                @endif
                            </td>
                            <td class="px-6 py-4 text-slate-500">{{ $loan->created_at->diffForHumans() }}</td>
                            <td class="px-6 py-4">
                                @if(!$loan->returned_at)
                                    <span class="text-slate-500 flex items-center gap-1">
                                        <div class="w-2 h-2 rounded-full bg-red-500"></div> Dışarıda
                                    </span>
                                @else
                                    <span class="text-slate-500 flex items-center gap-1">
                                        <div class="w-2 h-2 rounded-full bg-emerald-500"></div> Rafta
                                    </span>
                                @endif
                            </td>
                        </tr>
                    @endforeach
                    @if($recentLoans->isEmpty())
                        <tr>
                            <td colspan="5" class="px-6 py-8 text-center text-slate-400">
                                <i class="bi bi-inbox text-3xl mb-2 block"></i>
                                Henüz bir hareket yok.
                            </td>
                        </tr>
                    @endif
                </tbody>
            </table>
        </div>

        <!-- Tool Detail Modal -->
        <div x-show="toolModalOpen" style="display: none;" class="fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
            <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
                <!-- Background overlay -->
                <div x-show="toolModalOpen" @click="toolModalOpen = false" x-transition:enter="ease-out duration-300" x-transition:enter-start="opacity-0" x-transition:enter-end="opacity-100" x-transition:leave="ease-in duration-200" x-transition:leave-start="opacity-100" x-transition:leave-end="opacity-0" class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>

                <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

                <!-- Modal Panel -->
                <div x-show="toolModalOpen" x-transition:enter="ease-out duration-300" x-transition:enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" x-transition:enter-end="opacity-100 translate-y-0 sm:scale-100" x-transition:leave="ease-in duration-200" x-transition:leave-start="opacity-100 translate-y-0 sm:scale-100" x-transition:leave-end="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg w-full">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <div class="sm:flex sm:items-start">
                            <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-brand-100 sm:mx-0 sm:h-10 sm:w-10">
                                <i class="bi bi-tools text-brand-600 text-lg"></i>
                            </div>
                            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left w-full">
                                <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">
                                    <span x-text="selectedTool?.name"></span>
                                </h3>
                                <div class="mt-2 text-sm text-gray-500 space-y-1">
                                    <p>Seri No: <span x-text="selectedTool?.serial_number" class="font-mono font-bold text-gray-700"></span></p>
                                    <p class="text-xs text-gray-400" x-text="selectedTool?.description"></p>
                                    <div class="border-t border-gray-100 my-2 pt-2">
                                        <p class="font-semibold text-gray-700">Son İşlem:</p>
                                        <p>Personel: <span x-text="selectedTool?.current_personnel?.name"></span></p>
                                        <p>Tarih: <span x-text="new Date(selectedTool?.loan_info?.created_at).toLocaleDateString()"></span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse gap-2">
                        <button type="button" @click="toolModalOpen = false" class="w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                            Kapat
                        </button>
                        <!-- Dynamic Actions -->
                         <template x-if="selectedTool?.loan_info?.returned_at == null">
                            <a :href="`/loans/${selectedTool?.loan_info?.id}/return`" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-emerald-600 text-base font-medium text-white hover:bg-emerald-700 focus:outline-none sm:w-auto sm:text-sm">
                                İade Al
                            </a>
                        </template>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
