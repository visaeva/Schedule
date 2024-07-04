import SwiftUI
import UIKit

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Темная тема", isOn: $viewModel.isDarkMode)
                    .padding()
                    .font(.system(size: 17))
                    .foregroundColor(Color("blackDay"))
                    .tint(Color("blueUniversal"))
                    .onChange(of: viewModel.isDarkMode) { newValue in
                        toggleTheme(newValue)
                    }
                Button(action: {
                    viewModel.isWebViewPresented = true
                }) {
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
            .navigationTitle("Пользовательское соглашение")
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.black)
        }
        .fullScreenCover(isPresented: $viewModel.isWebViewPresented) {
            NavigationView {
                if viewModel.isInternetAvailable {
                    WebView()
                        .background(Color.whiteNight)
                        .navigationBarTitle("Пользовательское соглашение", displayMode: .inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    viewModel.isWebViewPresented = false
                                }) {
                                    Image(systemName: "chevron.left")
                                    
                                        .foregroundColor(Color("blackDay"))
                                }
                            }
                        }
                } else {
                    ErrorView(imageName: "internetError", errorText: "Нет интернета")
                        .background(Color.whiteNight)
                        .navigationBarTitle("", displayMode: .inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    viewModel.isWebViewPresented = false
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.title)
                                        .foregroundColor(Color("blackDay"))
                                }
                            }
                        }
                }
            }
            .onAppear {
                viewModel.checkInternetConnection()
            }
            
        }
    }
    
    private func toggleTheme(_ isDarkMode: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }
        }
    }
}
#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
