#include "SP.h"

const char* ssid = "star";
const char* password = "26931886";
const char* ws_host = "49.213.238.75";
const uint16_t ws_port = 8001;
const char* ws_path = "/ws/sensor/room_name/";

unsigned long lastResponseTime = 0; // 上次收到回應的時間
const unsigned long responseTimeout = 5000; // 超時時間 5000 毫秒 (5 秒)
