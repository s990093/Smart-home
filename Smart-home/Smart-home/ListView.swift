import SwiftUI

struct ListView: View {
    var body: some View {
        VStack {
            Text("即時環境數據")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            NavigationView {
                List {
                    EnvironmentDataView(dataType: "溫度", value: "24°C", iconName: "thermometer")
                    EnvironmentDataView(dataType: "濕度", value: "50%", iconName: "humidity")
                    EnvironmentDataView(dataType: "亮度", value: "800 Lux", iconName: "light.max")
                    
                    // 將 VideoView 包裝在 NavigationLink 中
                    NavigationLink(destination: StreamingView(streamURL: "http://172.20.10.5/capture")) {
                        EnvironmentDataView(dataType: "即時影像", value: "查看", iconName: "camera.fill")
                    }
                }
                .navigationTitle("環境數據")
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



struct VideoView: View {
    var dataType: String
    var value: String
    var iconName: String
    
    @State private var showStreamingView = false

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
            
            Button(action: {
                showStreamingView = true
            }) {
                Text(value)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
            }
            .background(
                NavigationLink(destination: StreamingView(streamURL: "http://172.20.10.5:81/stream"), isActive: $showStreamingView) {
                    EmptyView()
                }
            )
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(UIColor.systemGray5)))
    }
}
