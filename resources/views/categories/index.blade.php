<x-app-layout>
    <x-slot name="header">
        {{ __('Kategori Yönetimi') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                
                <div class="card p-6 h-fit">
                    <h3 class="text-lg font-bold text-slate-900 mb-4">Yeni Kategori</h3>
                    <form action="{{ route('categories.store') }}" method="POST" class="space-y-4">
                        @csrf
                        <div>
                            <x-input-label for="name" value="Kategori Adı" />
                            <x-text-input id="name" name="name" class="w-full mt-1" required/>
                        </div>
                        <x-primary-button class="w-full justify-center">
                            Kaydet
                        </x-primary-button>
                    </form>
                </div>

                <div class="card p-6">
                    <h3 class="text-lg font-bold text-slate-900 mb-4">Kategori Listesi</h3>
                    <ul class="space-y-2">
                        @foreach($categories as $cat)
                        <li class="flex justify-between items-center p-3 bg-slate-50 rounded-lg border border-slate-200">
                            <span class="text-slate-700 font-medium">{{ $cat->name }}</span>
                            <span class="text-xs bg-brand-100 text-brand-700 px-2 py-1 rounded-full font-bold">{{ $cat->tools_count }}</span>
                        </li>
                        @endforeach
                    </ul>
                </div>

            </div>
        </div>
    </div>
</x-app-layout>
