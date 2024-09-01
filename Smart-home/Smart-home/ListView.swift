import SwiftUI

struct ListView: View {
    var body: some View {
        VStack {
            Text("即時環境數據")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            List {
                EnvironmentDataView(dataType: "溫度", value: "24°C", iconName: "thermometer")
                EnvironmentDataView(dataType: "濕度", value: "50%", iconName: "humidity")
                EnvironmentDataView(dataType: "亮度", value: "800 Lux", iconName: "light.max")
                EnvironmentDataView(dataType: "即時影像", value: "查看", iconName: "camera.fill")
            }
        }
    }
}

struct EnvironmentDataView: View {
    var dataType: String
    var value: String
    var iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .padding()
            
            Text(dataType)
                .font(.title3)
                .fontWeight(.medium)
            
            Spacer()
            
            Text(value)
                .font(.title3)
                .fontWeight(.medium)
                .padding()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(UIColor.systemGray5)))
    }
}
