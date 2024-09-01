import SwiftUI

struct MoreView: View {
    var body: some View {
        VStack {
            Text("定時設置")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            DeviceTimerView(deviceName: "LED 1", iconName: "lightbulb.fill", color: .yellow)
            DeviceTimerView(deviceName: "LED 2", iconName: "lightbulb.fill", color: .yellow)
            DeviceTimerView(deviceName: "風扇", iconName: "wind", color: .blue)
            DeviceTimerView(deviceName: "吊扇", iconName: "fanblades.fill", color: .gray)
            
            Spacer()
        }
        .padding()
    }
}

struct DeviceTimerView: View {
    var deviceName: String
    var iconName: String
    var color: Color
    
    @State private var time = Date()
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(color)
                .padding()
            
            Text(deviceName)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            DatePicker("Set Timer", selection: $time, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .padding()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(UIColor.systemGray5)))
        .padding(.horizontal)
    }
}
