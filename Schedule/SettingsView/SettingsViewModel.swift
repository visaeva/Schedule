import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") private var storedIsDarkMode: Bool = false
    @Published var isInternetAvailable: Bool = true
    @Published var isWebViewPresented: Bool = false
    @Published var isDarkMode: Bool {
        didSet {
            storedIsDarkMode = isDarkMode
        }
    }
    
    init(isDarkMode: Bool = false) {
        self.isDarkMode = isDarkMode
        checkInternetConnection()
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
