#ifndef SP_H
#define SP_H
#include <Arduino.h>

extern const char* ssid;
extern const char* password;
extern const char* ws_host;
extern const uint16_t ws_port;
extern const char* ws_path;

extern unsigned long lastResponseTime; // 上次收到回應的時間
extern const unsigned long responseTimeout; // 超時時間 5000 毫秒 (5 秒)

#endif // SP_H
