
import SwiftUI

struct CustomBackButton: View {
    @State var iscliceked: Bool = false
    @Environment(\.presentationMode) private var presentationMode
    var text = "chevron.backward"
    var body: some View {
        Button {
            iscliceked.toggle()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: text)
                .font(.title3)
                .foregroundColor(.black2)
        }
    }
}

#Preview {
    CustomBackButton()
}
