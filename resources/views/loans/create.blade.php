<x-app-layout>
    <x-slot name="header">
        {{ __('Yeni Zimmet Oluştur') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
        <div class="max-w-2xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                
                <form action="{{ route('loans.store') }}" method="POST" class="space-y-6">
                    @csrf

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Tool Selection (Searchable) -->
                        <div class="bg-slate-50 p-4 rounded-lg border border-slate-200" 
                             x-data="{ 
                                open: false, 
                                search: '', 
                                selected: '', 
                                selectedName: '',
                                tools: {{ json_encode($activeTools->map(fn($t) => ['id' => $t->id, 'name' => $t->name, 'serial_number' => $t->serial_number, 'barcode' => $t->barcode])) }}
                             }"
                        >
                            <h3 class="text-sm font-bold text-slate-700 mb-3 flex items-center">
                                <i class="bi bi-tools mr-2 text-brand-500"></i> Verilecek Alet
                            </h3>
                            <input type="hidden" name="tool_id" :value="selected">
                            
                            <div class="relative">
                                <div @click="open = !open" class="block w-full bg-white border border-slate-300 rounded-lg shadow-sm p-3 flex justify-between items-center cursor-pointer">
                                    <span x-text="selectedName || 'Alet Ara veya Barkod Okut...'" :class="{'text-slate-400': !selectedName, 'text-slate-900 font-bold': selectedName}"></span>
                                    <i class="bi bi-chevron-down text-slate-400"></i>
                                </div>

                                <div x-show="open" @click.away="open = false" class="absolute z-10 w-full mt-1 bg-white border border-slate-200 rounded-lg shadow-lg max-h-60 overflow-y-auto" style="display: none;">
                                    <div class="p-2 sticky top-0 bg-white border-b border-slate-100">
                                        <input type="text" x-model="search" placeholder="İsim, Seri No veya Barkod..." class="w-full border-slate-300 rounded-md text-sm focus:ring-brand-500 focus:border-brand-500"
                                            @keydown.enter.prevent="
                                                // Auto-select if exact match (barcode scanner behavior)
                                                let match = tools.find(t => t.barcode === search || t.serial_number === search);
                                                if(match) { selected = match.id; selectedName = match.name + ' (' + match.serial_number + ')'; open = false; search = ''; }
                                            "
                                            autofocus
                                        >
                                    </div>
                                    <ul>
                                        <template x-for="tool in tools.filter(t => t.name.toLowerCase().includes(search.toLowerCase()) || t.serial_number.toLowerCase().includes(search.toLowerCase()) || (t.barcode && t.barcode.toLowerCase().includes(search.toLowerCase())))">
                                            <li @click="selected = tool.id; selectedName = tool.name + ' (' + tool.serial_number + ')'; open = false; search = ''" 
                                                class="px-4 py-2 hover:bg-brand-50 cursor-pointer text-sm text-slate-700 hover:text-brand-700">
                                                <div class="font-bold" x-text="tool.name"></div>
                                                <div class="text-xs text-slate-400" x-text="tool.serial_number"></div>
                                            </li>
                                        </template>
                                        <li x-show="tools.filter(t => t.name.toLowerCase().includes(search.toLowerCase()) || t.serial_number.toLowerCase().includes(search.toLowerCase())).length === 0" class="px-4 py-2 text-sm text-slate-400 text-center">
                                            Sonuç bulunamadı.
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <x-input-error :messages="$errors->get('tool_id')" class="mt-2" />
                        </div>

                        <!-- Personnel Selection (Searchable) -->
                         <div class="bg-slate-50 p-4 rounded-lg border border-slate-200" 
                             x-data="{ 
                                open: false, 
                                search: '', 
                                selected: '', 
                                selectedName: '',
                                personnel: {{ json_encode($personnel->map(fn($p) => ['id' => $p->id, 'name' => $p->name, 'department' => $p->department])) }}
                             }"
                        >
                            <h3 class="text-sm font-bold text-slate-700 mb-3 flex items-center">
                                <i class="bi bi-person mr-2 text-brand-500"></i> Teslim Alacak Personel
                            </h3>
                            <input type="hidden" name="personnel_id" :value="selected">
                            
                            <div class="relative">
                                <div @click="open = !open" class="block w-full bg-white border border-slate-300 rounded-lg shadow-sm p-3 flex justify-between items-center cursor-pointer">
                                    <span x-text="selectedName || 'Personel Ara...'" :class="{'text-slate-400': !selectedName, 'text-slate-900 font-bold': selectedName}"></span>
                                    <i class="bi bi-chevron-down text-slate-400"></i>
                                </div>

                                <div x-show="open" @click.away="open = false" class="absolute z-10 w-full mt-1 bg-white border border-slate-200 rounded-lg shadow-lg max-h-60 overflow-y-auto" style="display: none;">
                                    <div class="p-2 sticky top-0 bg-white border-b border-slate-100">
                                        <input type="text" x-model="search" placeholder="İsim ara..." class="w-full border-slate-300 rounded-md text-sm focus:ring-brand-500 focus:border-brand-500" autofocus>
                                    </div>
                                    <ul>
                                        <template x-for="p in personnel.filter(person => person.name.toLowerCase().includes(search.toLowerCase()))">
                                            <li @click="selected = p.id; selectedName = p.name; open = false; search = ''" 
                                                class="px-4 py-2 hover:bg-brand-50 cursor-pointer text-sm text-slate-700 hover:text-brand-700">
                                                <div class="font-bold" x-text="p.name"></div>
                                                <div class="text-xs text-slate-400" x-text="p.department"></div>
                                            </li>
                                        </template>
                                         <li x-show="personnel.filter(person => person.name.toLowerCase().includes(search.toLowerCase())).length === 0" class="px-4 py-2 text-sm text-slate-400 text-center">
                                            Sonuç bulunamadı.
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <x-input-error :messages="$errors->get('personnel_id')" class="mt-2" />
                        </div>
                    </div>

                    <!-- Notes -->
                    <div>
                        <x-input-label for="notes" :value="__('Notlar (Opsiyonel)')" />
                        <div class="mt-1 relative">
                            <textarea name="notes" id="notes" rows="2" class="block w-full bg-white border-slate-300 rounded-lg shadow-sm focus:border-brand-500 focus:ring focus:ring-brand-500/50 text-slate-900 placeholder-slate-400 pl-3 pt-3" placeholder="Teslim notu..."></textarea>
                        </div>
                    </div>

                    <div class="flex items-center justify-end pt-4 border-t border-slate-100">
                        <a href="{{ route('loans.index') }}" class="text-sm text-slate-500 hover:text-slate-700 mr-6 font-medium">İptal</a>
                        <button type="submit" class="bg-brand-600 hover:bg-brand-700 text-white font-bold py-3 px-8 rounded-xl shadow-lg shadow-brand-500/30 transform transition hover:-translate-y-0.5 flex items-center">
                            <i class="bi bi-box-arrow-right mr-2"></i>
                            Zimmetle
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
