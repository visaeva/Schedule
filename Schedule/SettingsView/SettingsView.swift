import SwiftUI
import UIKit

struct SettingsView: View {
    @State private var isFeatureEnabled = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showWebView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Темная тема", isOn: $isDarkMode)
                    .padding()
                    .font(.system(size: 17))
                    .foregroundColor(Color("blackDay"))
                    .tint(Color("blueUniversal"))
                NavigationLink(
                    destination: WebView()
                        .navigationTitle("Пользовательское соглашение")
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
            .onChange(of: isDarkMode) { newValue in
                toggleTheme(newValue)
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
    
}

#Preview {
    SettingsView()
}
