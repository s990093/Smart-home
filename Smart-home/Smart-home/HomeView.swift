import SwiftUI

struct HomeView: View {
    @State private var led1State = "0"
    @State private var led2State = "0"
    @State private var fanState = "0"
    @State private var ceilingFanState = "0"
    
    var body: some View {
        VStack {
            Text("智慧家具氣候管理")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            // 控制LED 1
            DeviceControlView(deviceName: "LED 1", iconName: "lightbulb.fill", color: .yellow, deviceState: $led1State, actionCode: "1234", deviceIndex: 0, onDeviceStateChange: handleDeviceStateChange)
            // 控制LED 2
            DeviceControlView(deviceName: "LED 2", iconName: "lightbulb.fill", color: .yellow, deviceState: $led2State, actionCode: "1234", deviceIndex: 1, onDeviceStateChange: handleDeviceStateChange)
            // 控制風扇
            DeviceControlView(deviceName: "風扇", iconName: "wind", color: .blue, deviceState: $fanState, actionCode: "1234", deviceIndex: 2, onDeviceStateChange: handleDeviceStateChange)
            // 控制吊扇
            DeviceControlView(deviceName: "吊扇", iconName: "fanblades.fill", color: .gray, deviceState: $ceilingFanState, actionCode: "1234", deviceIndex: 3, onDeviceStateChange: handleDeviceStateChange)
            
            Spacer()
        }
        .padding()
    }
    // 處理設備狀態變更的函數
    func handleDeviceStateChange(deviceIndex: Int, newState: String) {
        print("設備 \(deviceIndex) 的新狀態: \(newState)")
        sendMessage(deviceIndex: deviceIndex, newState: newState)
    }
    
    // 發送 WebSocket 消息
    func sendMessage(deviceIndex: Int, newState: String) {
        let wsURL = URL(string: "ws://49.213.238.75:8001/ws/sensor/room_name/")!
        let webSocketTask = URLSession.shared.webSocketTask(with: wsURL)
        webSocketTask.resume()
        
        let messageDict: [String: Any] = [
            "user": "test_user",
            "action_code": "1234",
            "args": ["\(led1State)\(led2State)\(fanState)\(ceilingFanState)"]
        ]
        
        if let messageData = try? JSONSerialization.data(withJSONObject: messageDict, options: []) {
            let message = URLSessionWebSocketTask.Message.data(messageData)
            webSocketTask.send(message) { error in
                if let error = error {
                    print("WebSocket 发送消息时发生错误: \(error)")
                } else {
                    print("消息发送成功")
                }
            }
        }
    }
}

struct DeviceControlView: View {
    let deviceName: String
    let iconName: String
    let color: Color
    @Binding var deviceState: String
    let actionCode: String
    let deviceIndex: Int
    let onDeviceStateChange: (Int, String) -> Void  // 回调函数
    
    
    
    @State private var isOn = false
    @State private var scale: CGFloat = 1.0
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(isOn ? color : .gray)
                .scaleEffect(scale)  // 添加缩放动画效果
                .rotationEffect(.degrees(rotationAngle))  // 添加旋转动画效果
                .animation(.easeInOut(duration: 0.5), value: isOn)  // 控制动画的类型和持续时间
                .padding()
            
            Text(deviceName)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Toggle(isOn: $isOn) {
                Text(isOn ? "On" : "Off")
                
            }
            .labelsHidden()
            .padding()
            .onChange(of: isOn) { value in
                // 切换状态
                let newState = value ? "1" : "0"
                deviceState = newState
                
                // 动画效果
                withAnimation {
                    scale = value ? 1.2 : 1.0
                    rotationAngle = value ? 360 : 0
                }
                
                // 调用回调函数，传递状态变化给 HomeView
                onDeviceStateChange(deviceIndex, newState)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(UIColor.systemGray5)))
        .padding(.horizontal)
    }
}




#Preview {
    HomeView()
}
