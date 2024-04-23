import SwiftUI

struct ErrorView: View {
    let imageName: String
    let errorText: String
    
    var body: some View {
        ZStack {
            Color.whiteNight
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 223, height: 223)
                    .cornerRadius(70)
                
                Text(errorText)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("blackDay"))
            }
            .padding()
        }
    }
}

#Preview {
    ErrorView(imageName: "serverError", errorText: "Ошибка сервера")
}

#Preview {
    ErrorView(imageName: "internetError", errorText: "Нет интернета")
}

