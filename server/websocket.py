import asyncio
import websockets
import json

async def test_websocket():
    uri = "ws://localhost:8000/ws/sensor/room_name/"  # 替換為你的 WebSocket URL

    # 模擬客户端連接到 WebSocket 伺服器
    async with websockets.connect(uri) as websocket:
        # 構造一個測試訊息
        test_message = {
            "user": "test_user",
            "action_code": "1234",
            "args": ["0110"]
        }

        # 將訊息轉換為 JSON 並發送
        await websocket.send(json.dumps(test_message))
        print(f"> Sent: {test_message}")

        # 接收來自伺服器的回應
        response = await websocket.recv()
        response_data = json.loads(response)
        print(f"< Received: {response_data}")

        # 確保伺服器的回應與預期的相符
        # assert response_data['user'] == "test_user"
        # assert response_data['action_code'] == "1234"
        # assert response_data['args'] == ["arg1", "arg2"]

# 啟動測試
asyncio.get_event_loop().run_until_complete(test_websocket())
