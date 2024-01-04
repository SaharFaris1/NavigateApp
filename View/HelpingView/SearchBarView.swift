//
//  SearchBarView.swift
//  Navigate
//
//  Created by Reem Alammari on 19/06/1445 AH.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray.opacity(0.5))
            TextField("exp1", text: $searchText)
                
        }.padding()
            .foregroundColor(.black)
            .font(.title3)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.blue2, lineWidth: 2)
                .fill(.white3)
                .overlay{
                    Button(action: {
                        self.searchText = ""
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(8)
                            
                    }
                    .opacity(searchText.isEmpty ? 0 : 1)
                    .offset(x: 120)
                }
            ).padding()
            .foregroundColor(.white)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
