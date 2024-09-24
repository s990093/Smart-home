#include "SensorManager.h"

// 初始化感測器
void initializeSensors() {
    ALS.begin();
    BMht.begin();
}

// 讀取感測數據
SensorData readSensorData() {
    SensorData data;
    data.lux = ALS.readLux(1);
    data.humidity = BMht.readHumidity();
    data.temperature = BMht.readTemperature();
    return data;
}

// 創建 BME82M131 物件，用於讀取光強度
BME82M131 ALS;
// 創建 BM25S2021_1 物件，用於讀取溫度和濕度
BM25S2021_1 BMht(&Wire);
