
import Foundation
import Lottie
import UIKit
import SwiftUI

struct LottieSwiftUIView: UIViewRepresentable {
  let url: URL

  func makeUIView(context: UIViewRepresentableContext<Self>) -> some UIView {
    let myView = UIView(frame: .zero)
    let animationView = LottieAnimationView()
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .loop
    
    print("start loading animation successfully")
    LottieAnimation.loadedFrom(url: url, closure: { animation in
      if let animation = animation {
        animationView.animation = animation
        animationView.play()
        print("did load animation successfully")
      } else {
        print("did not load animation :,(")
      }
    })
    
    myView.addSubview(animationView)
    animationView
      .translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint
      .activate([
      animationView.heightAnchor.constraint(equalTo: myView.heightAnchor),
      animationView.widthAnchor.constraint(equalTo: myView.widthAnchor)
    ])
    return myView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    
  }
}
