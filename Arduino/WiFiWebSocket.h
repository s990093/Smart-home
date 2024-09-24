#ifndef WIFIWEBSOCKET_H
#define WIFIWEBSOCKET_H

#include <ArduinoWebsockets.h>
#include <WiFi.h>
#include <ArduinoJson.h>  
#include <Arduino.h>
#include <SP.h>

using namespace websockets;

extern WebsocketsClient* client;

void connectToWiFi(const char* ssid, const char* password);
bool connectToWebSocket(WebsocketsClient* client, const char* host, uint16_t port, const char* path);
void sendMessage(const char* user, const char* action_code, float arg1, float arg2, float arg3);
void handleWebSocketMessage(WebsocketsMessage message);
void checkConnection(void);

#endif // WIFIWEBSOCKET_H