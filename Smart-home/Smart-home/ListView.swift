import SwiftUI

struct ListView: View {
    @StateObject private var webSocketManager = WebSocketManager()
    
    var body: some View {
        VStack {
            
            NavigationView {
                List {
                    Text("即時數據")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    EnvironmentDataView(dataType: "溫度", value: webSocketManager.temperature, iconName: "thermometer")
                    EnvironmentDataView(dataType: "濕度", value: webSocketManager.humidity, iconName: "humidity")
                    EnvironmentDataView(dataType: "亮度", value: webSocketManager.light, iconName: "light.max")
                    
                    // 將 VideoView 包裝在 NavigationLink 中
                    NavigationLink(destination: StreamingView(streamURL: "rtmp://49.213.238.75/live/123")) {
                        EnvironmentDataView(dataType: "即時影像", value: "查看", iconName: "camera.fill")
                    }
                }
                Spacer()
            }
            
        }
        .onAppear {
            webSocketManager.connect()
        }
        .onDisappear {
            webSocketManager.disconnect()
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
