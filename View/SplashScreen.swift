import SwiftUI
struct SplashScreen: View {
    @State private var isActive = false
    @Environment(\.colorScheme) var colorScheme
    @State private var size = 0.8
    @State private var didOnboard = false
    @State private var showOnboarding = false
    
    var body: some View {
        if isActive {
            OnboardingView(didOnboard: $didOnboard, showOnboarding: $showOnboarding)
        } else {
            VStack {
                if colorScheme == .dark {
                    Image("logo2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .scaleEffect(size)
                   
                } else {
                    Image("logo1")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .scaleEffect(size)

                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        self.size = 0.9
                        self.isActive = true
                    }
                }
            }
            .onDisappear {
                didOnboard = true
            }
        }
    }
}
#Preview {
    SplashScreen()
}
