<?php
session_start();
require_once '../../config/database.php';
require_once '../../includes/functions.php';
require_once '../../includes/ai_helper.php';

// Giriş kontrolü
if (!isset($_SESSION['kullanici_id'])) {
    header("Location: ../../login.php");
    exit();
}

$pageTitle = "AI Asistan";
include '../../includes/header.php';

$ai = new AIHelper();
?>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-gradient-primary text-white">
                    <h4 class="mb-0">
                        <i class="fas fa-robot me-2"></i>
                        Yapay Zeka Asistanı
                    </h4>
                </div>
                <div class="card-body">
                    
                    <!-- Hızlı Başlangıç Butonları -->
                    <div class="alert alert-info">
                        <h5>Hızlı Sorular:</h5>
                        <div class="d-flex flex-wrap gap-2">
                            <button class="btn btn-sm btn-outline-primary quick-ask" 
                                data-question="Bugün hangi aletler servise gönderildi?">
                                Bugünkü servis kayıtları
                            </button>
                            <button class="btn btn-sm btn-outline-primary quick-ask" 
                                data-question="Kalibrasyonu yaklaşan aletleri listele">
                                Kalibrasyon takibi
                            </button>
                            <button class="btn btn-sm btn-outline-primary quick-ask" 
                                data-question="En çok hasarlanan alet kategorisi hangisi?">
                                Hasar analizi
                            </button>
                            <button class="btn btn-sm btn-outline-primary quick-ask" 
                                data-question="Müsait tornavidaları göster">
                                Müsait aletler
                            </button>
                        </div>
                    </div>

                    <!-- Chat Alanı -->
                    <div id="chat-container" class="border rounded p-3 mb-3 bg-light" 
                         style="height: 500px; overflow-y: auto;">
                        <div class="text-center text-muted py-5">
                            <i class="fas fa-comments fa-3x mb-3"></i>
                            <p>Bir soru sorun veya komut verin...</p>
                        </div>
                    </div>

                    <!-- Input Alanı -->
                    <div class="input-group">
                        <input type="text" 
                               id="user-input" 
                               class="form-control form-control-lg" 
                               placeholder="Sorunuzu yazın... (örn: '5mm lokma anahtarı nerede?')"
                               autocomplete="off">
                        <button class="btn btn-primary btn-lg" id="send-btn">
                            <i class="fas fa-paper-plane me-2"></i> Gönder
                        </button>
                    </div>
                    
                    <div class="mt-2 text-muted small">
                        <i class="fas fa-lightbulb"></i> 
                        <strong>İpucu:</strong> Doğal dilde soru sorabilirsiniz. 
                        Örnek: "Zimmetli aletlerin listesini ver", "Bu hafta kaç alet kalibrasyon gördü?"
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.chat-message {
    margin-bottom: 15px;
    padding: 10px 15px;
    border-radius: 10px;
    max-width: 80%;
    animation: fadeIn 0.3s;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.user-message {
    background: #007bff;
    color: white;
    margin-left: auto;
    text-align: right;
}

.ai-message {
    background: #f8f9fa;
    border: 1px solid #dee2e6;
    margin-right: auto;
}

.typing-indicator {
    display: inline-block;
    padding: 10px 15px;
    background: #f8f9fa;
    border-radius: 10px;
}

.typing-indicator span {
    height: 8px;
    width: 8px;
    background: #999;
    display: inline-block;
    border-radius: 50%;
    margin: 0 2px;
    animation: typing 1.4s infinite;
}

.typing-indicator span:nth-child(2) {
    animation-delay: 0.2s;
}

.typing-indicator span:nth-child(3) {
    animation-delay: 0.4s;
}

@keyframes typing {
    0%, 60%, 100% { transform: translateY(0); }
    30% { transform: translateY(-10px); }
}
</style>

<script>
$(document).ready(function() {
    const chatContainer = $('#chat-container');
    const userInput = $('#user-input');
    const sendBtn = $('#send-btn');
    
    // Mesaj gönder
    function sendMessage() {
        const message = userInput.val().trim();
        if (!message) return;
        
        // Kullanıcı mesajını göster
        appendMessage('user', message);
        userInput.val('');
        
        // Typing indicator göster
        showTyping();
        
        // AI'ya gönder
        $.ajax({
            url: 'process_ai.php',
            method: 'POST',
            data: { message: message },
            dataType: 'json',
            success: function(response) {
                hideTyping();
                if (response.success) {
                    appendMessage('ai', response.reply);
                    
                    // Eğer veri var ise tablo göster
                    if (response.data) {
                        appendData(response.data);
                    }
                } else {
                    let errorMsg = 'Üzgünüm, bir hata oluştu: ' + response.error;
                    if (response.file) {
                        errorMsg += '\n\nDosya: ' + response.file + ' (Satır: ' + response.line + ')';
                    }
                    appendMessage('ai', errorMsg);
                    console.error('AI Hatası:', response);
                }
            },
            error: function(xhr, status, error) {
                hideTyping();
                let errorMsg = 'Bağlantı hatası oluştu.\n\n';
                errorMsg += 'Durum: ' + status + '\n';
                errorMsg += 'Hata: ' + error + '\n';
                errorMsg += 'HTTP Kod: ' + xhr.status + '\n';
                if (xhr.responseText) {
                    errorMsg += 'Yanıt: ' + xhr.responseText.substring(0, 200);
                }
                appendMessage('ai', errorMsg);
                console.error('AJAX Hatası:', xhr, status, error);
            }
        });
    }
    
    // Mesaj ekle
    function appendMessage(type, text) {
        const messageClass = type === 'user' ? 'user-message' : 'ai-message';
        const icon = type === 'user' ? '<i class="fas fa-user me-2"></i>' : '<i class="fas fa-robot me-2"></i>';
        
        const messageHtml = `
            <div class="chat-message ${messageClass}">
                ${icon} ${text}
            </div>
        `;
        
        chatContainer.append(messageHtml);
        chatContainer.scrollTop(chatContainer[0].scrollHeight);
    }
    
    // Typing indicator
    function showTyping() {
        const typingHtml = `
            <div class="typing-indicator" id="typing">
                <span></span><span></span><span></span>
            </div>
        `;
        chatContainer.append(typingHtml);
        chatContainer.scrollTop(chatContainer[0].scrollHeight);
    }
    
    function hideTyping() {
        $('#typing').remove();
    }
    
    // Veri tablosu ekle
    function appendData(data) {
        if (!Array.isArray(data) || data.length === 0) return;
        
        let tableHtml = '<div class="table-responsive mt-2"><table class="table table-sm table-bordered">';
        
        // Header
        tableHtml += '<thead class="table-light"><tr>';
        Object.keys(data[0]).forEach(key => {
            tableHtml += `<th>${key}</th>`;
        });
        tableHtml += '</tr></thead>';
        
        // Body
        tableHtml += '<tbody>';
        data.forEach(row => {
            tableHtml += '<tr>';
            Object.values(row).forEach(val => {
                tableHtml += `<td>${val || '-'}</td>`;
            });
            tableHtml += '</tr>';
        });
        tableHtml += '</tbody></table></div>';
        
        chatContainer.append(tableHtml);
        chatContainer.scrollTop(chatContainer[0].scrollHeight);
    }
    
    // Event listeners
    sendBtn.click(sendMessage);
    
    userInput.keypress(function(e) {
        if (e.which === 13) { // Enter tuşu
            sendMessage();
        }
    });
    
    // Hızlı sorular
    $('.quick-ask').click(function() {
        const question = $(this).data('question');
        userInput.val(question);
        sendMessage();
    });
});
</script>

<?php include '../../includes/footer.php'; ?>
