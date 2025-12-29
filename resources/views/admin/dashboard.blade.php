<x-app-layout>
    <x-slot name="header">
        <div class="flex justify-between items-center">
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ __('Süper Admin Paneli') }}
            </h2>
            <button onclick="document.getElementById('createWorkshopModal').showModal()" class="bg-brand-600 hover:bg-brand-700 text-white font-bold py-2 px-4 rounded-lg text-sm flex items-center">
                <i class="bi bi-plus-lg mr-2"></i> Yeni Şube/Takımhane Ekle
            </button>
        </div>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
            
            <!-- Global Stats -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                <div class="card p-6 border-l-4 border-brand-500">
                    <p class="text-sm text-slate-500 uppercase font-bold">Toplam Şube</p>
                    <p class="text-3xl font-display font-bold text-slate-800">{{ $stats['total_workshops'] }}</p>
                </div>
                <div class="card p-6 border-l-4 border-blue-500">
                    <p class="text-sm text-slate-500 uppercase font-bold">Toplam Kullanıcı</p>
                    <p class="text-3xl font-display font-bold text-slate-800">{{ $stats['total_users'] }}</p>
                </div>
                <div class="card p-6 border-l-4 border-emerald-500">
                    <p class="text-sm text-slate-500 uppercase font-bold">Toplam Ekipman</p>
                    <p class="text-3xl font-display font-bold text-slate-800">{{ $stats['total_tools'] }}</p>
                </div>
                <div class="card p-6 border-l-4 border-amber-500">
                    <p class="text-sm text-slate-500 uppercase font-bold">Aktif Zimmet</p>
                    <p class="text-3xl font-display font-bold text-slate-800">{{ $stats['active_loans'] }}</p>
                </div>
            </div>

            <!-- Workshops List -->
            <div class="card">
                <div class="px-6 py-4 border-b border-slate-200 bg-slate-50/50">
                    <h3 class="text-lg font-display font-semibold text-slate-800">Şubeler / Takımhaneler</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 text-slate-500 text-xs uppercase tracking-wider border-b border-slate-200">
                            <tr>
                                <th class="px-6 py-3 font-semibold">Şube Adı</th>
                                <th class="px-6 py-3 font-semibold">Kullanıcı Sayısı</th>
                                <th class="px-6 py-3 font-semibold">Ekipman Sayısı</th>
                                <th class="px-6 py-3 font-semibold">Oluşturulma</th>
                                <th class="px-6 py-3 font-semibold text-right">İşlemler</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-200 text-sm">
                            @foreach($workshops as $workshop)
                                <tr class="hover:bg-slate-50 transition">
                                    <td class="px-6 py-4 font-bold text-slate-900">{{ $workshop->name }}</td>
                                    <td class="px-6 py-4">
                                        <span class="bg-blue-100 text-blue-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">{{ $workshop->users_count }}</span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="bg-emerald-100 text-emerald-800 text-xs font-semibold px-2.5 py-0.5 rounded-full">{{ $workshop->tools_count }}</span>
                                    </td>
                                    <td class="px-6 py-4 text-slate-500">{{ $workshop->created_at->format('d.m.Y') }}</td>
                                    <td class="px-6 py-4 text-right">
                                        <a href="{{ route('workshops.users.create', $workshop) }}" class="text-brand-600 hover:text-brand-900 font-medium mr-3">Kullanıcı Ekle</a>
                                        <!-- <button class="text-slate-400 hover:text-slate-600"><i class="bi bi-three-dots"></i></button> -->
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Create Workshop Modal (Native Dialog) -->
    <dialog id="createWorkshopModal" class="modal rounded-xl shadow-xl p-0 backdrop:bg-gray-900/50">
        <div class="w-full max-w-md bg-white rounded-xl overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-200 bg-slate-50 flex justify-between items-center">
                <h3 class="text-lg font-bold text-slate-800">Yeni Şube Ekle</h3>
                <form method="dialog">
                    <button class="text-slate-400 hover:text-slate-600"><i class="bi bi-x-lg"></i></button>
                </form>
            </div>
            <form action="{{ route('workshops.store') }}" method="POST" class="p-6 space-y-4">
                @csrf
                <div>
                    <x-input-label for="name" :value="__('Şube / Takımhane Adı')" />
                    <x-text-input id="name" name="name" type="text" class="mt-1 block w-full" required autofocus placeholder="Örn: Ankara Merkez Atölye" />
                </div>
                
                <div class="flex justify-end pt-4">
                    <button type="submit" class="bg-brand-600 hover:bg-brand-700 text-white font-bold py-2 px-6 rounded-lg shadow-lg shadow-brand-500/30">
                        Oluştur
                    </button>
                </div>
            </form>
        </div>
    </dialog>
</x-app-layout>
