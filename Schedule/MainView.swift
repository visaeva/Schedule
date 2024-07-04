import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            TabBarView()
        }
    }
}

struct TabBarView: View {
    @State private var storiesCellView: StoriesCellView = StoriesCellView()
    @State private var placeView: PlaceView = PlaceView()
    @State private var settingsView: SettingsView = SettingsView(viewModel: SettingsViewModel())
    
    var body: some View {
        TabView {
            // Главный экран
            ZStack {
                VStack {
                    StoriesCellView()
                        .padding(.leading, 10)
                        .padding(.bottom, 20)
                    placeView
                        .padding(.leading, -5)
                    Spacer()
                    
                }
            }
            .background(Color.whiteNight)
            .tabItem {
                Label("", systemImage: "arrow.up.message.fill")
            }
            
            // Настройки
            ZStack {
                settingsView
            }
            .tabItem {
                Label("", systemImage: "gearshape")
            }
        }
        .accentColor(Color("blackDay"))
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 1)
                .foregroundColor(Color("grayUniversal"))
                .padding(.top, 650)
        )
    }
}


#Preview {
    MainView()
}
