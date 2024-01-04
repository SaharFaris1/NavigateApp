
import SwiftUI

struct RoundedRectangleViewFilled: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 22.0)
            .frame(width: 50, height: 6)
            .foregroundColor(.blue2)
    }
}

#Preview {
    RoundedRectangleViewFilled()
}
