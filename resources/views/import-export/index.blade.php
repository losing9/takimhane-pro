<x-app-layout>
    <x-slot name="header">
        Veri İçe/Dışa Aktarma (Excel/CSV)
    </x-slot>

    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
        <div class="p-6 text-gray-900">
            @if(session('success'))
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
                    <span class="block sm:inline">{{ session('success') }}</span>
                </div>
            @endif

            @if(session('error'))
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                    <span class="block sm:inline">{{ session('error') }}</span>
                </div>
            @endif

            @if($errors->any())
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <!-- Import Section -->
                <div class="border p-6 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">İçe Aktar (Import)</h3>
                    <p class="text-sm text-gray-600 mb-4">
                        Desteklenen formatlar: .csv, .xlsx, .xls
                        <br>
                        CSV Yapısı: <code>Seri Numarası, Kategori (İsim), Raf, Açıklama, Stok Giriş Tarihi</code>
                    </p>
                    
                    <form action="{{ route('import') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                            <div class="mb-4">
                                <label class="block mb-2 text-sm font-medium text-gray-900" for="file_input">Dosya Seçin:</label>
                                <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded cursor-pointer bg-gray-50 focus:outline-none" id="file_input" type="file" name="file" required>
                            </div>
                            <button type="submit" class="w-full text-white bg-indigo-600 hover:bg-indigo-700 focus:ring-4 focus:ring-indigo-300 font-bold rounded-lg text-sm px-5 py-3 mr-2 mb-2 focus:outline-none shadow-lg">
                                YÜKLE VE İÇERİ AKTAR
                            </button>
                    </form>
                </div>

                <!-- Export Section -->
                <div class="border p-6 rounded-lg">
                    <h3 class="text-lg font-semibold mb-4">Dışa Aktar (Export)</h3>
                    <p class="text-sm text-gray-600 mb-4">Veritabanındaki tüm aletleri Excel veya CSV formatında indir.</p>
                    
                    <div class="flex gap-4">
                        <a href="{{ route('export') }}" class="text-white bg-green-600 hover:bg-green-700 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 focus:outline-none">
                            Excel Olarak İndir (.xlsx)
                        </a>
                        <a href="{{ route('export-csv') }}" class="text-white bg-green-500 hover:bg-green-600 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 focus:outline-none">
                            CSV Olarak İndir (.csv)
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
