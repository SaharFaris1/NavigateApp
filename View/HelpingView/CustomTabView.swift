
import SwiftUI
struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var namespace
    
    let tabBarItem = ["qrcode.viewfinder", "person"]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 8 * 6)
                .foregroundColor(.blue4)
                .shadow(radius: 2)
                .overlay {
                    HStack(spacing: 0) {
                        ForEach(0..<2) { index in
                            Button {
                                tabSelection = index + 1
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 180, height: 8 * 6)
                                    .foregroundColor(index + 1 == tabSelection ? .blue2 : .clear)
                                    .overlay {
                                        if tabSelection == 1 {
                                            Image(systemName: index + 1 == tabSelection ? "qrcode.viewfinder" : "person")
                                                .foregroundColor(.white2)
                                        } else {
                                            Image(systemName: index + 1 == tabSelection ? "person" : "qrcode.viewfinder")
                                                .foregroundColor(.white2)
                                        }
                                    }
                            }
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .font(.title2)
                    .bold()
                }
        }
        .padding(.horizontal)
    }
}


#Preview {
    CustomTabView(tabSelection: .constant(1))
}
