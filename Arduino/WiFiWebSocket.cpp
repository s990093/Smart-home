#include "WiFiWebSocket.h"

void connectToWiFi(const char* ssid, const char* password) {
    WiFi.begin(ssid, password);
    for (int i = 0; i < 10 && WiFi.status() != WL_CONNECTED; i++) {
        Serial.print(".");
        delay(500);
    }

    if (WiFi.status() != WL_CONNECTED) {
        Serial.println("WiFi 連接失敗！");
    } else {
        Serial.println("已連接到 WiFi");
    }
}

bool connectToWebSocket(WebsocketsClient* client, const char* host, uint16_t port, const char* path) {
    return client->connect(host, port, path);
}

void sendMessage(const char* user, const char* action_code, float arg1, float arg2, float arg3) {
    StaticJsonDocument<256> doc;
    doc["user"] = user;
    doc["action_code"] = action_code;

    // 將每個參數轉換成字串，第一個參數不含小數點
    char arg1_str[10], arg2_str[10], arg3_str[10];
    snprintf(arg1_str, sizeof(arg1_str), "%.0f", arg1);  // 沒有小數點
    snprintf(arg2_str, sizeof(arg2_str), "%.1f", arg2);  // 保留1位小數
    snprintf(arg3_str, sizeof(arg3_str), "%.1f", arg3);  // 保留1位小數

    // 將字串形式的參數添加到 JSON 的陣列中
    JsonArray args = doc.createNestedArray("args");
    args.add(arg3_str);
    args.add(arg2_str);
    args.add(arg1_str);

    // 序列化並發送
    String message;
    serializeJson(doc, message);
    client->send(message);

    Serial.print("已發送: ");
    Serial.println(message);
}


void handleWebSocketMessage(WebsocketsMessage message) {
    lastResponseTime = millis(); // 更新上次收到回應的時間
    Serial.print("接收到訊息: ");
    Serial.println(message.data());

    StaticJsonDocument<256> responseDoc;  // 使用 StaticJsonDocument
    deserializeJson(responseDoc, message.data());
    const char* user = responseDoc["user"];
    const char* action_code = responseDoc["action_code"];
    float arg3 = responseDoc["args"][0];
    float arg2 = responseDoc["args"][1];
    float arg1 = responseDoc["args"][2];

    Serial.print("用戶: ");
    Serial.println(user);
    Serial.print("操作代碼: ");
    Serial.println(action_code);
    Serial.print("光強度: ");
    Serial.println(arg1);
    Serial.print("濕度: ");
    Serial.println(arg2);
    Serial.print("溫度: ");
    Serial.println(arg3);
}

void checkConnection() {
    if (millis() - lastResponseTime > responseTimeout) {
        Serial.println("超過 5 秒未收到 WebSocket 回應");
        esp_restart();
    }
    Serial.println("check ok!");
}
