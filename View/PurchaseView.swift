
import SwiftUI
import StoreKit

struct PurchaseView: View {
    @StateObject var vmPerson = ProfileViewModel()
    @StateObject var purchaseVM = PuchaseViewModel()
    @StateObject var storekit = StoreKitManager()
    var body: some View {
        ZStack {
            Color.white3
                .ignoresSafeArea()
            VStack(spacing: 10.0){
                HStack(spacing: 80){
                    CustomBackButton()
                        .foregroundColor(.white3)
                    Text("pur2")
                        .bold()
                        .foregroundColor(.black2)
                        .font(.title2)
                    
                }.padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                                ZStack {
//                                    UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 30).fill(.white3)
//                                        .ignoresSafeArea()
                                  

                ScrollView{
                    VStack{
                        Spacer()
                            .frame(height: 20)
                        ForEach(vmPerson.pro.indices , id:\.self){ index in
                            
                            VStack(alignment: .leading, spacing: 20.0){
                                
                                RoundedRectangle(cornerRadius: 8*2.5)
                                    .stroke(Color.blue2, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 8*30)
                                    .overlay{
                                        VStack{
                                            VStack(alignment: .leading, spacing: 15.0) {
                                                
                                                Text("pur9")
                                                    .bold()
                                                
                                                Text(vmPerson.pro[index].en_fullName )
                                                
                                                
                                            }.frame(maxWidth: .infinity , alignment: .leading)
                                            Divider()
                                                .background(.blue2)
                                                .frame(width: 320)
                                            
//                                            VStack(alignment: .leading , spacing: 15.0) {
//                                                
//                                                
//                                                Text("pur3")
//                                                    .bold()
//                                                
//                                                Text(vmPerson.pro[index].mobile)
//                                            
//                                            }.frame(maxWidth: .infinity , alignment: .leading)
//                                            
//                                            Divider()
//                                                .background(.blue2)
//                                                .frame(width: 320)
                                            
                                            
                                            VStack(alignment: .leading, spacing: 15.0) {
                                                
                                                Text("pur4")
                                                    .bold()
                                                
                                                Text(vmPerson.pro[index].email)
                                            }.frame(maxWidth: .infinity , alignment: .leading)
                                            
                                        }.frame(maxWidth: .infinity , alignment: .leading)
                                            .padding(.horizontal)
                                    }
                                        
                                       
                                
                                
                                RoundedRectangle(cornerRadius: 8*2.5)
                                    .stroke(Color.blue2, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 8*14)
                                    .overlay{
                                        VStack(alignment: .leading, spacing: 15.0) {
                                            
                                            HStack {
                                               
                                                Text("pur5")
                                                    .bold()
                                                Image(systemName: "creditcard")
                                            }
                                            
                                            Text("pur6")
                                        }.frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal)
                                    }
                               
                                            
                                        
                                        
                                        NavigationLink {
                                            TermsAndConditionView()
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            
                                            Text("pur7")
                                                .foregroundColor(.blue2.opacity(0.8))
                                                .underline()
                                                .padding(.leading)
                                            
                                            
                                        }
                                    
                            }
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .font(.title2)
                            .padding()
                            Spacer()
                                .frame(height: 50)
                            
                        }.foregroundColor(.black2)
                        
                        ForEach(storekit.storeProducts){ product in
                            Text(product.displayName)
                            Spacer()
                            Button(action: {
                                Task{
                                    try await storekit.purchase(product)
                                }
                            }, label: {
                                CustomButton(text: NSLocalizedString("pur8", comment: ""), size: 8 * 45)
                                    .foregroundColor(.black2)
                                
                            })
                        }
                        
                    }
                    
                }
            }
        }
        }
        
    }
}

struct CourseItem: View {
    @StateObject var storekit = StoreKitManager()
    @State var isPurchased: Bool = false
    var product: Product
    var body: some View {
        VStack{
            if isPurchased{
                Text(Image(systemName: "checkmark"))
                    .bold()
                    .padding(10)
                
            }else{
                Text(product.displayPrice)
                    .padding(10)
            }
        }.onChange(of: storekit.purchaseCourses){ course, value in
            Task{
                isPurchased = (try? await storekit.isPurchase(product)) ?? false
            }
        }
    }
}


#Preview {
    PurchaseView()
}
