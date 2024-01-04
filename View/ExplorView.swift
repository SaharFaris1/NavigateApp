
import SwiftUI
struct ExploreView: View {
    @State var searchText = ""
    @StateObject var vm = ExploreViewModel()
    @State var isActive: Bool = false
    @State var isActive2: Bool = false
    @State var showAlertX: Bool = false
    @State var showSignUpView: Bool = false
    @State private var selectedItem: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.blue2
                    .ignoresSafeArea()

           
                if vm.explore.isEmpty {
                    LottieSwiftUIView(
                        url: URL(string: "https://lottie.host/437a2476-60a9-420f-bd03-ccd4b4d7b407/J8h31PWd97.json")!
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }else {
                    VStack{
                        SearchBarView(searchText: $vm.searchText)
                        VStack{
                            ZStack {
                                UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30).fill(.white3)
                                    .ignoresSafeArea()
                                    .ignoresSafeArea()
                         ScrollView{
                                    
                                    VStack(spacing: 20){
                                        Spacer()
                                           
                                
                                        ForEach(vm.filteredSearch.indices, id: \.self){ index in
                                            NavigationLink {
                                                TuwaiqView()
                                                    .navigationBarBackButtonHidden(true)
                                            } label: {
                                                
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.blue2, lineWidth: 2)
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 135)
                                                    .shadow(radius: 0.5)
                                                    .overlay{
                                                        HStack {
                                                            AsyncImage(url: vm.explore[index].placeimg){image in
                                                                image
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(maxWidth: .infinity)
                                                                    .frame(height: 8*15)
                                                                
                                                                
                                                            }placeholder: {
                                                                ProgressView()
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                
                                                
                                            }.padding(.horizontal)
                                        }
                                        
                                        Button(action: {
                                            self.showAlertX = true
                                            
                                        }) {
                                            ZStack{
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(Color.blue2, lineWidth: 2)
                                                    .stroke(Color.blue2)
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height:130)
                                                    .shadow(radius: 0.5)
                                                Text("exp2")
                                                    .font(.title2)
                                                    .foregroundColor(.blue2)
                                                    .bold()
                                                
                                            }.padding(.horizontal)
                                            
                                        }
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        
                                        
                                    }
                                    
                                }
                            }
                            //------------------------------------------//
                        } .onAppear {
                            
                            Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { _ in
                                vm.fetchPlaces()
                            }
                        }
                    }
                    if showAlertX {
                        ZStack {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                            
                            VStack(spacing: 20) {
                                Button(action: {
                                    self.showAlertX = false
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.black2)
                                        .frame(maxWidth: .infinity , alignment: .trailing)
                                        .padding(.top, 90)
                                        .padding(.trailing, 20)
                                }.padding(.top)
                                
                                Text("exp3")
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.black2)
                                
                                NavigationLink {
                                    
                                    SignupView()
                                        .navigationBarBackButtonHidden()
                                        .onAppear{
                                            showAlertX.toggle()
                                        }
                                } label: {
                                    CustomButton(text: NSLocalizedString("exp4", comment: "") , size: 8*36)
                                        .padding(.bottom , 120)
                                }.padding(.horizontal)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(.white2)
                            .cornerRadius(10)
                            .shadow(radius: 20)
                            .padding()
                        }
                    }
                    
                    
                }
            }
        }
    }
}


#Preview {
    ExploreView()
}


