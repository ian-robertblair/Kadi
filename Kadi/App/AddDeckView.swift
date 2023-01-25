//
//  AddDeckView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import SwiftUI

struct AddDeckView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addDeckViewModel = AddDeckViewModel()
    @StateObject var decksViewModel:DecksViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack(alignment: .leading) {
                    Text("Name: ")
                        .padding(.horizontal, 20)
                        .font(.title2)
                        .foregroundColor(Color("CardColor"))
                    TextField("Enter name...", text: $addDeckViewModel.name)
                        .foregroundColor(Color("CardColor"))
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color("CardColor"), lineWidth: 2)
                        }
                        
                }
                .padding()
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .font(.title)
                
               
                Spacer()
                Button {
                    //
                    addDeckViewModel.addDeck()
                    decksViewModel.getDecks()
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Save")
                        .frame(width: 200)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .background(Color("CardColor"))
                        .cornerRadius(40)
                        .foregroundColor(Color("TextColor"))
                        .padding(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color("CardColor"), lineWidth: 5)
                            )
                }//Button

                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
            
        }//NAV

      
    }
}

struct AddDeckView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeckView(decksViewModel: DecksViewModel())
    }
}
