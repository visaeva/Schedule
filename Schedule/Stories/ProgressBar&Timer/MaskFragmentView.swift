
import SwiftUI

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
              .fixedSize(horizontal: false, vertical: true)
              .frame(height: .progressBarHeight)
              .foregroundStyle(.white)
    }
}

#Preview {
    MaskFragmentView()
}
