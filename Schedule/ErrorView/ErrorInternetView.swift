import SwiftUI

struct ErrorInternetView: View {
    var body: some View {
        ZStack {
            Color.whiteNight
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("internetError")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 223, height: 223)
                    .cornerRadius(70)
                
                Text("Нет интернета")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("blackDay"))
            }
            .padding()
        }
    }
}
#Preview {
    ErrorInternetView()
}
