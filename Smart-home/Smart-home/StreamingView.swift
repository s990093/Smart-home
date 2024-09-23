import SwiftUI

struct StreamingView: View {
    var streamURL: String
    @State private var errorMessage: String?
    @State private var currentImage: UIImage?
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("即時影像")
                .font(.largeTitle)
                .padding()
            
            if let errorMessage = errorMessage {
                // 如果有錯誤，顯示錯誤訊息
                Text("錯誤: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if let currentImage = currentImage {
                // 正常顯示圖片
                Image(uiImage: currentImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .cornerRadius(15)
                    .padding()
            } else {
                // 當圖片尚未獲取時，顯示一個進度指示器
                ProgressView("載入中...")
                    .frame(height: 300)
                    .cornerRadius(15)
                    .padding()
            }
            
            Spacer()
        }
        .navigationTitle("即時影像播放")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // 開始定時獲取圖片
            startImageCapture()
        }
        .onDisappear {
            // 停止定時器
            timer?.invalidate()
        }
    }

    private func startImageCapture() {
        // 定時每0.5秒獲取一次圖片
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            fetchImage()
        }
    }

    private func fetchImage() {
        // 此處進行圖片獲取的邏輯
        guard let url = URL(string: streamURL) else {
            errorMessage = "無效的 URL"
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = error.localizedDescription
                }
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    errorMessage = "無法獲取圖片"
                }
                return
            }

            DispatchQueue.main.async {
                currentImage = image
            }
        }
        
        task.resume()
    }
}
