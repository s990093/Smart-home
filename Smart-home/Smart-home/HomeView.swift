import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("智慧家具氣候管理")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            // 控制LED 1
            DeviceControlView(deviceName: "LED 1", iconName: "lightbulb.fill", color: .yellow)
            // 控制LED 2
            DeviceControlView(deviceName: "LED 2", iconName: "lightbulb.fill", color: .yellow)
            // 控制風扇
            DeviceControlView(deviceName: "風扇", iconName: "wind", color: .blue)
            // 控制吊扇
            DeviceControlView(deviceName: "吊扇", iconName: "fanblades.fill", color: .gray)
            
            Spacer()
        }
        .padding()
    }
}

struct DeviceControlView: View {
    var deviceName: String
    var iconName: String
    var color: Color
    
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
                withAnimation {
                    // 动画效果：当设备状态改变时，图标会缩放和旋转
                    scale = value ? 1.2 : 1.0
                    rotationAngle = value ? 360 : 0
                }
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
