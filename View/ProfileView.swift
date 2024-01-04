
import SwiftUI

struct ProfileView: View {
        @StateObject var vmP = ProfileViewModel()
        @State var isSheetPresented: Bool = false
        @State var editname: String = ""
        @State var iscliceked: Bool = false
        @Environment(\.presentationMode) private var presentationMode
        @State var editNum: String = ""
 var body: some View {
        ZStack {
 ScrollView {
                VStack {
                    HStack{
                      CustomBackButton()
                        Spacer()
                        
                        Text("pro1")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity)
                        Spacer()
                        
                    }.padding(.horizontal)
                        .padding(.bottom)
                    ProfileHeaderView()
                        .padding(.top , 50)
                    
                    ForEach(vmP.pro) { profile in
                        Text(profile.en_fullName)
                            .font(.title2)
                            .bold()
                    }
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue2)
                                .frame(width: 150, height: 40)
                            Text("pro2")
                                .foregroundColor(.white)
                            
                        }
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        VStack {
                            Text("pro3")
                                .font(.title)
                                .bold()
                            
                            TextField("pro4", text: $editname)
                                .foregroundColor(.black)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.3)))
                                .padding()
                            TextField("pro5", text: $editNum)
                                .foregroundColor(.black)
                                .font(.title3)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(RoundedRectangle(cornerRadius: 16).stroke(.gray.opacity(0.3)))
                                .padding()
                            Button(action: {
                                vmP.updateProfile(name: editname, mobile: editNum)
                                isSheetPresented.toggle()
                            }) {
                                Text("pro6")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 350, height: 50)
                                    .background(Color.blue2)
                                    .cornerRadius(10)
                                    .presentationDetents([.medium])
                            }
                        }
                    }
                    
                    Divider()
                    
                    ForEach(vmP.pro) { profile in
                        VStack(spacing: 40) {
                            
                            VStack(spacing: 10.0){
                                Text("pro7")
                                    .font(.title2)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(profile.en_fullName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(spacing: 10.0){
                                Text("pro8")
                                    .font(.title2)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(profile.email)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            VStack(spacing: 10.0){
                                Text("pro9")
                                    .font(.title2)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(profile.mobile)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                    }.padding()
                }
            } .onAppear {
                vmP.fetchProfile(id: UUID())
            }
        }
    }
  }

#Preview {
    ProfileView()
}

