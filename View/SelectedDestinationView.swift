
import SwiftUI
import WebKit

struct SelectedDestinationView: View {
    @StateObject var navigateVM = NavigateViewModel()
    @StateObject var scanVM  = QRScannerDelegate()
    @StateObject var routeVM = RoutViewModel()
    @State private var fromLocation = 0
    @State private var toDestination = 0
    @State private var selectedItem: Bool = false
    @State private var showLottie = false
    @State var fromDestination: Int = 10
    @State var toTheDestination: Int = 4
    @State var forImagePlace: Int = 0
    @State var isScan = false
    @State private var isDataLoaded = false
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.locale) var locale
    
    @State var scannedCode: String = ""
   
    var body: some View {
     
            ZStack {
              
            if navigateVM.navigate.isEmpty {
                LottieSwiftUIView(
                    url: URL(string: "https://lottie.host/437a2476-60a9-420f-bd03-ccd4b4d7b407/J8h31PWd97.json")!
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }else {
                
                VStack(spacing: 10.0){
                    UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30).fill(.white3)
                        .ignoresSafeArea()
                        .ignoresSafeArea()
                
                    HStack{
                        CustomBackButton()
                        Spacer()
                        Text("sel1")
                            .font(.title2)
                        Spacer()
                    }.padding(.bottom)
                    // .padding(.top)
                    Spacer()
                    HStack(spacing: 180.0){
                        Text("sel2")
                            .foregroundColor(.black2)
                        NavigationLink(destination: ScanView(scannedCode: $scannedCode)
                                            .navigationBarBackButtonHidden(true),
                                       label: {
                                           Image(systemName: "qrcode.viewfinder")
                                               .font(.largeTitle)
                                               .foregroundColor(.blue2)
                                       })

                    } .onChange(of: scannedCode) { newValue , newValue2 in
                        handleScannedCode(newValue2)
                        if let scannedInt = Int(newValue2 ?? "") {
                            fromSelection(scannedInt)
                        } else {
                            print("Invalid scanned code format")
                        }
                    }
                
                    RoundedRectangle(cornerRadius: 8*2.5)
                        .stroke(Color.blue2, lineWidth: 1)
                        .frame(height: 50)
                        .foregroundColor(.white3)
                        .overlay{
                            HStack {
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(.blue2)
                                        .font(.footnote)
                                    Text("sel3")
                                        .foregroundColor(.black2)
                                        .font(.title3)
                                }
                                Spacer()
                                // Text(scanVM.scannedCode ?? "")
                                Picker("sel3", selection: $fromLocation ) {
                                    ForEach(navigateVM.navigate.indices, id:\.self){ index in
                                        
                                        HStack{
                                            
                                            let place = locale.language.languageCode?.identifier == "en" ? navigateVM.navigate[index].en_place_name:
                                            navigateVM.navigate[index].ar_place_name
                                            let floorNum = locale.language.languageCode?.identifier == "en" ? navigateVM.navigate[index].en_number_floor :
                                            navigateVM.navigate[index].ar_number_floor
                                            Text("\(place)  - \(floorNum)").tag(Int(index))
                                        }
                                    }
                                }
                            }
                            .tint(.black2)
                            .padding(.horizontal)
                            .pickerStyle(.menu)
                            .onChange(of: fromLocation) { newValue, value2 in
                                if isScan{
                                    handleScannedCode(scanVM.scannedCode)
                                }else{
                                    fromSelection(value2)
                                    fromDestination = navigateVM.navigate[value2].place_id
                                    forImagePlace = value2
                                }
                            }
                        }
                    //  }
                    //----------------------------------------------------
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue2, lineWidth: 1)
                        .frame(height: 50)
                        .foregroundColor(.white3)
                        .overlay{
                            HStack {
                                HStack {
                                    Image(systemName: "pin.fill")
                                        .foregroundColor(.red)
                                        .font(.callout)
                                    Text("sel4")
                                        .foregroundColor(.black2)
                                        .font(.title3)
                                }
                                Spacer()
                                Picker("sel4", selection: $toDestination) {
                                    ForEach(navigateVM.navigate.indices, id:\.self){ index in
                                        HStack{
                                            let place1 = locale.language.languageCode?.identifier == "en" ?
                                            navigateVM.navigate[index].en_place_name :
                                            navigateVM.navigate[index].ar_place_name
                                            
                                            let floorNum1 = locale.language.languageCode?.identifier == "en" ?
                                            navigateVM.navigate[index].en_number_floor :
                                            navigateVM.navigate[index].ar_number_floor
                                            Text("\(place1) -  \(floorNum1)").tag(Int(index))
                                        }
                                    }
                                }
                                .tint(.black2)
                                .pickerStyle(.menu)
                                .onChange(of: toDestination) { newValue, value2 in
                                    handleSelection(value2)
                                    toTheDestination = navigateVM.navigate[value2].place_id
                                }
                            }.padding(.horizontal)
                                
                        }
                    
                    
                    
                    let image = navigateVM.navigate[forImagePlace].place_image
                    
                    WebView(urlString: image)
                        .navigationBarTitle("", displayMode: .large)
                        .frame(height: 530)
                        .border(.blue2, width: 3)
                        .cornerRadius(16)
                    
                    
                    
                    
                    
                    
                }.padding(.top)
                    .padding(.horizontal)
                    .onAppear {
                        
                        Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { _ in
                            navigateVM.fetchData()
                        }
                    }
                   
                   
            }
            
            //popup:-
            if selectedItem {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            self.selectedItem = false
                            
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black2)
                                .frame(maxWidth: .infinity , alignment: .trailing)
                                .padding(.top, 110)
                                .padding(.trailing, 20)
                        }.padding(.top)
                        let place2 = locale.language.languageCode?.identifier == "en" ? navigateVM.navigate[toDestination].en_place_name :
                        navigateVM.navigate[toDestination].ar_place_name
                        Text(NSLocalizedString("sel5", comment: "") + " " + place2)
                            .font(.title3)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.black3)
                        
                        
                        ForEach(routeVM.route.indices, id:\.self){ path in
                            
                            
                            if fromDestination == routeVM.route[path].idFrom  && toTheDestination == routeVM.route[path].idTo {
                                NavigationLink {
                                    FollowBreadcrubsView(destination: "\(navigateVM.navigate[toDestination].en_place_name)", placeImage: routeVM.route[path].path)
                                        .navigationBarBackButtonHidden(true)
                                        .onAppear{
                                            selectedItem.toggle()
                                        }
                                    
                                    
                                } label: {
                                    CustomButton(text: NSLocalizedString("sel6", comment: "") , size: 8*36)
                                        .padding(.bottom , 120)
                                }.padding(.horizontal)
                            }
                        }
                        
                    }
                    .frame(width: 320, height: 180)
                    .background(.white2)
                    .cornerRadius(10)
                    .shadow(radius: 20)
                }
            }
            }.refreshable{
            print("gggggggggggggggg")
                print(scanVM.scannedCode ?? "")
            }
        
    }
     func fromSelection(_ index: Int) {
        
        print("From Destination: \(navigateVM.navigate[index].en_place_name)")
    }
     func handleSelection(_ index: Int) {
        
        selectedItem = true
        print("To Destination: \(navigateVM.navigate[index].en_place_name)")
    }
    //post gress
     func handleScannedCode(_ scannedCode: String?) {
        guard let scannedCode = scannedCode,
              let code = Int(scannedCode) else {
            print("Invalid scanned code.")
            return
        }
        
        if let index = navigateVM.navigate.firstIndex(where: { $0.place_id == code }) {
            fromLocation = index
            fromDestination = navigateVM.navigate[index].place_id
            forImagePlace = index
            print("From Destination: \(navigateVM.navigate[index].en_place_name)")
        } else {
            print("Scanned code not recognized.")
        }
    }
}

#Preview {
    SelectedDestinationView()
}
