<div x-data="{ open: false, messages: [], newMessage: '', isLoading: false }" 
     class="fixed bottom-6 right-6 z-50 flex flex-col items-end">

    <!-- Chat Window -->
    <div x-show="open" 
         x-transition:enter="transition ease-out duration-300"
         x-transition:enter-start="opacity-0 translate-y-4 scale-95"
         x-transition:enter-end="opacity-100 translate-y-0 scale-100"
         x-transition:leave="transition ease-in duration-200"
         x-transition:leave-start="opacity-100 translate-y-0 scale-100"
         x-transition:leave-end="opacity-0 translate-y-4 scale-95"
         class="mb-4 w-96 bg-white rounded-2xl shadow-2xl border border-slate-200 overflow-hidden flex flex-col font-sans"
         style="display: none; height: 500px;">
        
        <!-- Header -->
        <div class="bg-slate-900 p-4 flex justify-between items-center text-white rounded-t-2xl">
            <div class="flex items-center gap-3">
                <div class="p-1.5 bg-brand-500/20 rounded-lg">
                    <i class="bi bi-robot text-brand-400"></i>
                </div>
                <div>
                    <h3 class="font-bold text-sm">Takımhane Asistan</h3>
                    <p class="text-[10px] text-slate-400">Yapay Zeka Destekli</p>
                </div>
            </div>
            <button @click="open = false" class="text-slate-400 hover:text-white transition">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>

        <!-- Messages Area -->
        <div class="flex-1 overflow-y-auto p-4 space-y-4 bg-slate-50" id="chat-messages">
            <!-- Welcome Message -->
            <div class="flex gap-3">
                <div class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center flex-shrink-0">
                    <i class="bi bi-robot text-slate-500 text-xs"></i>
                </div>
                <div class="bg-white p-3 rounded-2xl rounded-tl-none border border-slate-100 shadow-sm text-sm text-slate-600">
                    Merhaba! Ben Takımhane Asistanı. Aletler, bakımlar veya zimmet durumu hakkında bana soru sorabilirsin.
                </div>
            </div>

            <template x-for="(msg, index) in messages" :key="index">
                <div :class="msg.isUser ? 'flex-row-reverse' : ''" class="flex gap-3">
                    <div class="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0"
                         :class="msg.isUser ? 'bg-brand-100 text-brand-600' : 'bg-slate-200 text-slate-500'">
                        <i :class="msg.isUser ? 'bi bi-person' : 'bi bi-robot'" class="text-xs"></i>
                    </div>
                    <div class="max-w-[80%] p-3 rounded-2xl border shadow-sm text-sm"
                         :class="msg.isUser ? 'bg-brand-600 text-white rounded-tr-none border-transparent' : 'bg-white text-slate-600 rounded-tl-none border-slate-100'">
                        <p x-text="msg.text"></p>
                    </div>
                </div>
            </template>
            
            <!-- Loading Indicator -->
            <div x-show="isLoading" class="flex gap-3">
                <div class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center flex-shrink-0">
                    <i class="bi bi-robot text-slate-500 text-xs"></i>
                </div>
                <div class="bg-white p-3 rounded-2xl rounded-tl-none border border-slate-100 shadow-sm">
                    <div class="flex space-x-1">
                        <div class="w-2 h-2 bg-slate-400 rounded-full animate-bounce delay-75"></div>
                        <div class="w-2 h-2 bg-slate-400 rounded-full animate-bounce delay-150"></div>
                        <div class="w-2 h-2 bg-slate-400 rounded-full animate-bounce delay-300"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Input Area -->
        <div class="p-4 bg-white border-t border-slate-100">
            <form @submit.prevent="sendMessage" class="relative">
                <input x-model="newMessage" 
                       type="text" 
                       placeholder="Bir şeyler sorun..." 
                       class="w-full pl-4 pr-12 py-3 bg-slate-50 border-transparent focus:border-brand-500 focus:bg-white focus:ring-0 rounded-xl text-sm transition-all shadow-inner"
                       :disabled="isLoading">
                <button type="submit" 
                        class="absolute right-2 top-2 p-1.5 bg-brand-600 text-white rounded-lg hover:bg-brand-700 disabled:opacity-50 transition shadow-sm shadow-brand-500/30"
                        :disabled="!newMessage.trim() || isLoading">
                    <i class="bi bi-send-fill text-xs"></i>
                </button>
            </form>
        </div>
    </div>

    <!-- Toggle Button -->
    <button @click="open = !open" 
            class="group h-14 w-14 bg-slate-900 rounded-full shadow-2xl flex items-center justify-center hover:scale-105 transition-all duration-300 focus:outline-none ring-4 ring-slate-900/20">
        <i x-show="!open" class="bi bi-chat-left-dots-fill text-xl text-white group-hover:animate-pulse"></i>
        <i x-show="open" class="bi bi-x-lg text-xl text-white" style="display: none;"></i>
        
        <!-- Pulse Effect -->
        <span class="absolute inline-flex h-full w-full rounded-full bg-slate-400 opacity-20 animate-ping" x-show="!open"></span>
    </button>

    <script>
        function sendMessage() {
            const text = this.newMessage.trim();
            if (!text) return;

            this.messages.push({ text: text, isUser: true });
            this.newMessage = '';
            this.isLoading = true;
            
            // Auto scroll
            this.$nextTick(() => {
                const chatContainer = document.getElementById('chat-messages');
                chatContainer.scrollTop = chatContainer.scrollHeight;
            });

            fetch('/ai/ask', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                },
                body: JSON.stringify({ message: text })
            })
            .then(res => res.json())
            .then(data => {
                this.messages.push({ text: data.response, isUser: false });
                this.isLoading = false;
                
                this.$nextTick(() => {
                    const chatContainer = document.getElementById('chat-messages');
                    chatContainer.scrollTop = chatContainer.scrollHeight;
                });
            })
            .catch(err => {
                console.error(err);
                this.messages.push({ text: 'Bir hata oluştu.', isUser: false });
                this.isLoading = false;
            });
        }
    </script>
</div>
