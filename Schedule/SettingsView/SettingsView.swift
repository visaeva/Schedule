import SwiftUI
import UIKit

struct SettingsView: View {
    @State private var isFeatureEnabled = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var isInternetAvailable = true
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Темная тема", isOn: $isDarkMode)
                    .padding()
                    .font(.system(size: 17))
                    .foregroundColor(Color("blackDay"))
                    .tint(Color("blueUniversal"))
                NavigationLink(
                    destination: isInternetAvailable ? AnyView(WebView()
                        .navigationTitle("Пользовательское соглашение") 
                        .background(Color.whiteNight)) : AnyView(ErrorView(imageName: "internetError", errorText: "Нет интернета"))
                ) {
                    HStack {
                        Text("Пользовательское соглашение")
                            .padding()
                            .foregroundColor(Color("blackDay"))
                            .font(.system(size: 17))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("blackDay"))
                            .frame(width: 25, height: 25)
                            .scaleEffect(1.4)
                            .padding()
                    }
                }
                .navigationBarHidden(true)
                Spacer()
                Text("Приложение использует API «Яндекс.Расписания»")
                    .font(.system(size: 12))
                    .foregroundColor(Color("blackDay"))
                    .padding(.bottom, 20)
                Text("Версия 1.0 (beta)")
                    .font(.system(size: 12))
                    .foregroundColor(Color("blackDay"))
                    .padding(.bottom, 20)
            }
            .background(Color.whiteNight)
            .onChange(of: isDarkMode) { newValue in
                toggleTheme(newValue)
            }
            .onAppear {
                checkInternetConnection()
            }
            .navigationTitle("Пользовательское соглашение")
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.black)
        }
    }
    
    func toggleTheme(_ isDarkMode: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
        }
    }
    
    func checkInternetConnection() {
        guard let url = URL(string: "https://yandex.ru/legal/practicum_offer/") else { return }
        
        URLSession.shared.dataTask(with: url) { (_, response, error) in
            if let error = error {
                print("Error checking internet connection: \(error)")
                DispatchQueue.main.async {
                    self.isInternetAvailable = false
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    self.isInternetAvailable = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isInternetAvailable = false
                }
            }
        }.resume()
    }
}

#Preview {
    SettingsView()
}
