
import SwiftUI

struct CustomButton: View {
    var text: String = NSLocalizedString("But", comment: "")
    var size: CGFloat = 8*45
    var body: some View {
        Text(text)
            .font(.title2)
            .bold()
     .foregroundColor(.white2)
            .frame(maxWidth: .infinity)
            .frame(width: size,height: 8*7 )
            .background(RoundedRectangle(cornerRadius: 8*2.5).foregroundColor(.blue2))
            .padding()
    }
}

#Preview {
    CustomButton()
}
