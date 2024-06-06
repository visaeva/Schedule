import SwiftUI

struct MaskView: View {
    let numberOfSections: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()}
        }
    }
}

#Preview {
    Color.storyBackground
        .ignoresSafeArea()
        .overlay(
            MaskView(numberOfSections: 5)
                .padding()
        )
}
