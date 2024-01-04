
import SwiftUI
import AVKit

struct ScanView: View {
    @State var isScanning: Bool = false
    @State var session: AVCaptureSession = .init()
    @State var cameraPermission: Permission = .idle
    @State var qrOutput: AVCaptureMetadataOutput = .init()
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @Environment(\.openURL) private var openURL
    @StateObject var qrDelegate = QRScannerDelegate()
    @State private var showScanningCompleteAlert = false
    @Environment(\.presentationMode) private var presentationMode

    @Binding var scannedCode: String

    var body: some View {
        ZStack{
            VStack(spacing: 8.0){
                
                CustomBackButton(text: "xmark")
                .frame(maxWidth: .infinity , alignment: .leading)
               
           
                
                GeometryReader{
                    let size = $0.size
                    ZStack{
                        CameraView(frameSize: CGSize(width: size.width, height: size.width) , session: $session)
                            .scaleEffect(0.97)
                        ForEach(0...4, id: \.self){ index in
                            let rotation = Double(index) * 90
                            
                            RoundedRectangle(cornerRadius: 4 , style: .circular)
                                .trim(from: 0.61 , to: 0.64)
                                .stroke(Color.blue2, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                                .rotationEffect(.init(degrees: rotation))
                        }
                        
                     
                        
                        
                    }
                    .frame(width: size.width , height: size.width)
                    .overlay(alignment: .top, content:{
                        Rectangle()
                            .fill(.blue2)
                            .frame(height: 2.5)
                            .shadow(radius: 8 , x: 0 , y: isScanning ? 15 : -15 )
                            .offset(y: isScanning ? size.width : 0)
                    })
                    .frame(maxWidth: .infinity , maxHeight: .infinity)
                    
                    
                }.padding(.horizontal , 45)
                
                Text("scan1")
                    .font(.title2).bold()
                    .foregroundColor(.black2.opacity(0.8))
                Spacer()
                Spacer()
                Button {
                    if !session.isRunning && cameraPermission == .approved {
                        reactivateCamera()
                        activateScannerAnimation()
                    }
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.largeTitle)
                        .foregroundColor(.black2)
                }
                

                Spacer(minLength: 55)
                
                
            }.padding(15)
                .onAppear(perform: checkCameraPermission)
                .alert(errorMessage, isPresented: $showError){
                    if cameraPermission == .denied{
                        Button("Setting"){
                            let settingsString = UIApplication.openSettingsURLString
                            if let settingsURL = URL(string: settingsString){
                                openURL(settingsURL)
                            }
                        }
                    }
                    
                }
                .onChange(of: qrDelegate.scannedCode) { value1, value2 in
                   
                        if let code = value2 {
                            scannedCode = code
                            session.stopRunning()
                            
                            deActivateScannerAnimation()
                            qrDelegate.scannedCode = nil
                            showScanningCompleteAlert = true
                        }
                     
                }



        }
    }
    func reactivateCamera(){
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func activateScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    
    func deActivateScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85)){
            isScanning = false
        }
    }
    
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty {
                    setupCamera()
                } else {
                    session.startRunning()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermission = .approved
                    
                        setupCamera()
                   
                } else {
                    cameraPermission = .denied
                    presentError("scan3")
                }
            case .denied, .restricted:
                cameraPermission = .denied
                presentError("scan4")
            default: break
            }
        }
    }

    
    func setupCamera(){
        do{
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("Unkown Device Error")
                
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else{
                presentError("Unkown Input/Output Error")
                
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate , queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        }catch{
            presentError(error.localizedDescription)
        }
    }
    
    
    func presentError(_ message: String){
        errorMessage = message
        showError.toggle()
    }
}

//#Preview {
//    ScanView()
//}
