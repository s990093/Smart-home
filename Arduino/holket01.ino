#include <Arduino.h>
#include <SensorManager.h>
#include <SP.h>
#include <Ticker.h>
#include <WiFiWebSocket.h>

// 初始化 Ticker 物件
Ticker ticker1;
Ticker connectionTicker;

// 初始化 client 指標
WebsocketsClient* client;

void setup() {
    Serial.begin(115200); // 啟動序列通訊

    // 連接到 WiFi
    connectToWiFi(ssid, password);

    // 初始化 WebSocket 客戶端
    client = new WebsocketsClient();

    // 嘗試連接 WebSocket 伺服器
    if (connectToWebSocket(client, ws_host, ws_port, ws_path)) {
        Serial.println("成功連接到 WebSocket 伺服器！");
    } else {
        Serial.println("連接 WebSocket 伺服器失敗！");
    }

    // 定義當接收到訊息時的行為
    client->onMessage([&](WebsocketsMessage message) {
        handleWebSocketMessage(message);
    });

    // 初始化感測器
    initializeSensors();

    // 每 5 秒呼叫一次 checkConnection 函數
    connectionTicker.attach(5, checkConnection);

    // 每 1 秒呼叫一次 tickerCallback 函數
    ticker1.attach(1, tickerCallback);
}

void loop() {
    // 檢查 WebSocket 是否有新訊息
    if (client->available()) {
        client->poll(); // 處理接收到的訊息
    }
}

// 定時發送訊息的函數
void tickerCallback() {
    SensorData data = readSensorData();  // 讀取感測數據
    sendMessage("ESP32", "9999", data.lux, data.humidity, data.temperature); // 發送訊息
}
