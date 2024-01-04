
import SwiftUI
import Lottie

struct OnboardingView: View {
    @State private var currentPage = 0
       @Binding var didOnboard: Bool
       @Binding var showOnboarding: Bool
    var body: some View {
        
        NavigationStack {
            VStack(spacing: -30.0) {
                ZStack {
                    LottieSwiftUIView(
                        url: URL(string: "https://lottie.host/2f4554e1-0850-418e-a1b4-aeb23d3f81fa/duiuTx7nTY.json")!
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                }
                   ZStack{

                    
                        TabView(selection: $currentPage) {
                            ForEach(0..<3) { i in
                                VStack(spacing: 65.0) {

                                    HStack(spacing: 10) {
                                        ForEach(0..<3) { j in
                                            if currentPage == j {
                                                RoundedRectangleViewFilled()
                                            } else {
                                                RoundedRectangleViewLight()
                                                    .opacity(0.2)
                                            }
                                        }
                                    }.padding()
                                    
                                    VStack(spacing: 45.0) {
                                        ZStack{                                            Text(pages[i].title)
                                                .font(.title)
                                                .bold()
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.blue2)
                                        }
                                        if currentPage == 2 {
                                            NavigationLink(destination: ExploreView()
                                                .navigationBarBackButtonHidden(true)
                                            ) {
                                                CustomButton()
                                            }
                                            
                                        } else {
                                            HStack(spacing: 190.0) {
                                                NavigationLink(destination: ExploreView()
                                                    .navigationBarBackButtonHidden(true)
                                                ) {
                                                    Text("on4")
                                                        .foregroundColor(.blue2).opacity(0.8)
                                                        .bold()
                                                        .font(.title3)
                                                }
                                           
                                                Button {
                                                    withAnimation {
                                                        currentPage += 1
                                                    }
                                                } label: {
                                             
                                                    
                                                    Text("on5")
                                                        .foregroundColor(.white3)
                                                        .font(.title2)
                                                        .bold()
                                                        .background(RoundedRectangle(cornerRadius: 8*2.5)
                                                            .fill(.blue2)
                                                            .frame(width: 120, height: 8*6)
                                                                    
                                                        )
                                                }
                                            }
                                        }
                                    }.padding(.horizontal)
                                }
                            }
                        }.tabViewStyle(.page(indexDisplayMode: .never))
                    }
                   .onAppear {
                       if !UserDefaults.standard.bool(forKey: "didOnboard") {
                                      UserDefaults.standard.set(true, forKey: "didOnboard")
                                      didOnboard = true
                                      showOnboarding = true
                       } else {
                                      showOnboarding = false //
                                  
                                  }
                              }
                 
            }
        }
    }
}




#Preview {
    OnboardingView( didOnboard: .constant(false), showOnboarding: .constant(false))
}



struct UsingTabView: Identifiable{
    var id = UUID()
    var image: String
    var title : String
    
}

let pages:[UsingTabView] =
[
    UsingTabView(image: "navigate1", title: NSLocalizedString("on1", comment: "")),
    UsingTabView(image: "navigate1",title: NSLocalizedString("on2", comment: "")),
    UsingTabView(image: "navigate1",title: NSLocalizedString("on3", comment: "")),
    
]


struct Wave: Shape {
    
    var waveHeight: CGFloat
    var phase: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY)) // Bottom Left
        
        for x in stride(from: 0, through: rect.width, by: 1) {
            let relativeX: CGFloat = x / 50 //wavelength
            let sine = CGFloat(sin(relativeX + CGFloat(phase.radians)))
            let y = waveHeight * sine //+ rect.midY
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) // Top Right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom Right
        
        return path
    }
}


