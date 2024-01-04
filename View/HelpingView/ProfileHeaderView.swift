import PhotosUI
import SwiftUI

struct ProfileHeaderView: View {
    @State private var imageItem: PhotosPickerItem?
    @State private var image: Image?
    @State private var isPickerPresented = false
    @State var isSheetPresented: Bool = false
    @State var editname: String = ""
    var body: some View {
        ZStack{
            VStack{
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                      .clipShape(Circle())
                      .frame(width: 100, height: 100)
                     
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 50)
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 100, height: 90)
                        )
                }
   Menu {
       Button(action: {
                          isPickerPresented = true
                      }) {
                          HStack {
                              Image(systemName: "photo.on.rectangle.angled")
                              Text("Change picture")
                          }
                      }
                  } label: {
                      Image(systemName: "square.and.pencil")
                          .resizable()
                          .scaledToFit()
                          .frame(width: 25, height: 25)
                          .frame(alignment: .trailing)
                          .foregroundColor(.blue2)
//                          .background(
//                            Circle().fill(.blue2)
//                                .frame(width: 35, height: 35)
//                          ).padding()
                          
                  }.offset(x: 30, y: -15)
                  
                  
              }
          }
          .sheet(isPresented: $isPickerPresented) {
              ImagePickerView(image: $image)
          }
      }
  }
#Preview {
    ProfileHeaderView()
}
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: Image?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let selectedImage = results.first else {
                return
            }
            
            selectedImage.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                } else if let uiImage = object as? UIImage {
                    DispatchQueue.main.async {
                        self.parent.image = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}

