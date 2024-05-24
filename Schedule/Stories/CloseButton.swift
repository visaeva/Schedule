
import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("close")
                .resizable()
                .frame(width: 30, height: 30)
        }
        .padding()
    }
}
