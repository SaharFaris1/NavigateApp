
import SwiftUI

struct DropMenue: Identifiable{
    var id = UUID()
    var title: String
}

struct CustomMenu: View {
    var drop = [DropMenue(title: "item1"), DropMenue(title: "item2"), DropMenue(title: "item3"), DropMenue(title: "item4")]
    @State var show = false
    @State var name = "item1"
    var body: some View {
        VStack{
           
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white2)
                    .overlay{
                        ScrollView{
                            VStack(spacing: 15){
                                ForEach(drop){ item in
                                    
                                    Button {
                                        withAnimation{
                                            name = item.title
                                            show.toggle()
                                        }
                                    } label: {
                                        Text(item.title)
                                            .foregroundColor(.black2)
                                        Spacer()
                                    }
       
                                }
                                .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.vertical, 15)
                        }
                    }.frame(height: show ?  200 : 40 )
                    .offset(y:show ? 0 : -135)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white2)
                    .frame(height: 50)
                    .overlay{
                        HStack{
                            Text(name)
                                .font(.title2)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .rotationEffect(.degrees(show ?  90 : 0))
                            
                        }
                        .bold()
                        .padding(.horizontal)
                        .foregroundColor(.black2)
                        
                    }
                    .offset(y: -130)
                    .onTapGesture {
                        withAnimation{
                            show.toggle()
                        }
                    }
            }
        }.padding()
            .frame(height: 200)
            .offset(y: 30)
    }
}

#Preview {
    CustomMenu()
}
