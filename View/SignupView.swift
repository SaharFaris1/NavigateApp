
import SwiftUI
struct SignupView: View {
    @StateObject var vmm = AuthenticationViewModel()
    @StateObject var vmPerson = ProfileViewModel()
    @State var firstName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isActive: Bool = false
    @State var isActive2: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @State var id = UUID()
    @State private var showAlert = false
    
    var isValidInput: Bool {
        return !firstName.isEmpty && !email.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        
        VStack(spacing: 20.0) {
            HStack {
                CustomBackButton()
                Spacer()
                Text("signup1")
                    .foregroundColor(.black2)
                    .bold()
                Spacer()
            }
            VStack {
                ScrollView {
                    if colorScheme == .dark {
                        Image("logo4")
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image("logo3")
                            .resizable()
                            .scaledToFit()
                    }
                    VStack(spacing: 15.0){
                        VStack (spacing: 2.0){
                            Text("signup2")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title2)
                            TextField("signup2", text: $firstName)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.3)))
                                .foregroundColor(.black2)
                        }.padding(.horizontal)
                     
                        VStack (spacing: 2.0){
                            Text("signup4")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title2)
                            TextField("signup5", text: $email)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.3)))
                                .foregroundColor(.black2)
                        }.padding(.horizontal)
                        
                        VStack(spacing: 2.0) {
                            Text("signup6")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title2)
                            SecureField("signup7", text: $password)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.3)))
                                .foregroundColor(.black2)
                        }.padding(.horizontal)
                        
                    }.padding()
                    NavigationLink{
                        PurchaseView()
                            .navigationBarBackButtonHidden(true)
                    } label:{ CustomButton(text: NSLocalizedString("signup8", comment: ""))
                    }
                        .onTapGesture {
                            if isValidInput {
                                vmm.signUp(email: email, password: password)
                                vmPerson.fetchProfile(id: id)
                            } else {
                                showAlert = true
                            }
                            
                        }.padding(.horizontal)
                        .padding(.top)
                    
                    HStack{
                        Text("signup9")
                            .foregroundColor(.black2)
                        
                        
                        Button(action: {
                            isActive2 = true
                            
                            
                        }) {
                            Text("signup10")
                                .foregroundColor(.blue2)
                        }.fullScreenCover(isPresented:$isActive2 ) {
                            SigninView()
                            
                        }
                    }.padding()
                    
                    
                }
            }.padding(.horizontal)
            
            
        }.padding(10)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("signup11"),
                    message: Text("signup12"),
                    dismissButton: .default(Text("signup13"))
                )
            }
    }
}

#Preview {
    SignupView()
}

