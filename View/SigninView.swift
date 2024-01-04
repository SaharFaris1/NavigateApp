
import SwiftUI

struct SigninView: View {
    @StateObject var vmm = AuthenticationViewModel()
    @StateObject var vmPerson = ProfileViewModel()
    @State var email: String = ""
    @State var password: String = ""
    @State var isActive: Bool = false
    @State var isActive2: Bool = false
    @State var isPresent = false
    @State var id = UUID()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    @State private var showAlert = false

    var isValidInput: Bool {
        return !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 30.0) {
                HStack {
                    CustomBackButton(text: "xmark")
                    Spacer()
                }
                if colorScheme == .dark {
                    Image("logo4")
                        .resizable()
                        .scaledToFit()
                } else {
                    Image("logo3")
                        .resizable()
                        .scaledToFit()
                }
                Spacer()
                VStack {
                    Text("signin1")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                    TextField("signin2", text: $email)
                        .foregroundColor(.black)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.3)))
                }.padding(.top)
                VStack {
                    Text("signin3")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                    SecureField("signin4", text: $password)
                        .foregroundColor(.black)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.3)))
                }.padding(.bottom)

                NavigationLink {
                    PurchaseView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    CustomButton(text: NSLocalizedString("signin5", comment: ""))
                }
                .disabled(!isValidInput)
                .onTapGesture {
                    if isValidInput {
                        vmm.signIn(email: email, password: password)
                        vmPerson.fetchProfile(id: id)
                    } else {
                        showAlert = true
                    }
                }
                
                HStack {
                    Text("signin6")
                        .foregroundColor(.black2)
                    Button(action: {
                        isActive2 = true
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("signin7")
                            .foregroundColor(.blue2)
                    }
                }.padding()
            }
            .padding(.horizontal)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("signin8"),
                    message: Text("signin9"),
                    dismissButton: .default(Text("signin10"))
                )
            }
        }
    }
}

#Preview {
    SigninView()
}

