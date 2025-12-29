<x-app-layout>
    <x-slot name="header">
        {{ __('Yeni Kullanıcı Ekle') }}
    </x-slot>

    <div class="py-12">
        <div class="max-w-xl mx-auto sm:px-6 lg:px-8">
            <div class="card p-6">
                <div class="mb-6 border-b border-slate-100 pb-4">
                    <h3 class="text-lg font-bold text-slate-800">Şube Yöneticisi Oluştur</h3>
                    <p class="text-sm text-slate-500">Bu kullanıcı <span class="font-bold text-brand-600">{{ $workshop->name }}</span> takımhanesini yönetecek.</p>
                </div>

                <form action="{{ route('workshops.users.store', $workshop) }}" method="POST" class="space-y-4">
                    @csrf

                    <div>
                        <x-input-label for="name" :value="__('Ad Soyad')" />
                        <x-text-input id="name" class="block mt-1 w-full" type="text" name="name" :value="old('name')" required autofocus />
                        <x-input-error :messages="$errors->get('name')" class="mt-2" />
                    </div>

                    <div>
                        <x-input-label for="email" :value="__('E-posta Adresi')" />
                        <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required />
                        <x-input-error :messages="$errors->get('email')" class="mt-2" />
                    </div>

                    <div>
                        <x-input-label for="password" :value="__('Şifre')" />
                        <x-text-input id="password" class="block mt-1 w-full" type="password" name="password" required autocomplete="new-password" />
                        <x-input-error :messages="$errors->get('password')" class="mt-2" />
                    </div>

                    <div>
                        <x-input-label for="password_confirmation" :value="__('Şifre Tekrar')" />
                        <x-text-input id="password_confirmation" class="block mt-1 w-full" type="password" name="password_confirmation" required />
                        <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
                    </div>

                    <div class="flex items-center justify-end mt-4 pt-4 border-t border-slate-100">
                        <a href="{{ route('dashboard') }}" class="text-sm text-slate-500 hover:text-slate-700 mr-4">İptal</a>
                        <button type="submit" class="bg-brand-600 hover:bg-brand-700 text-white font-bold py-2 px-6 rounded-lg shadow-lg shadow-brand-500/30">
                            Kullanıcıyı Oluştur
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
