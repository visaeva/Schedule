
import SwiftUI

struct ErrorServerView: View {
    var body: some View {
        VStack {
            Image("serverError")
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
                .cornerRadius(70)
            
            Text("Ошибка сервера")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("blackDay"))
        }
        .padding()
    }
}

#Preview {
    ErrorServerView()
}
