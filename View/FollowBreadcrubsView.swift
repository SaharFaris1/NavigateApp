
import SwiftUI
import WebKit
struct FollowBreadcrubsView: View {
    @ObservedObject var vmFilter = NavigateViewModel()
    var destination: String = ""
    var placeImage: String = ""
    var body: some View {
        ZStack{
            
            VStack(spacing: 10.0){
                HStack{
                    CustomBackButton()
                    
                    Spacer()
                    Text("fol1").bold()
                        .font(.title2) + Text("\(destination)") .font(.title2).bold()
                    
                        .foregroundColor(.black2)
                        .bold()
                    Spacer()
                    
                }.padding(.horizontal)
                
                Spacer()
                
            }
            
            WebView(urlString: placeImage)
                .navigationBarTitle("", displayMode: .large)
                .frame(height: 650)
            
            
            
        }
        
    }
}

#Preview {
    FollowBreadcrubsView()
}


struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        
    }
}
