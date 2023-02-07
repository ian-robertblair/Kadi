//
//  AddCardView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showValidationAlert: Bool = false
    @StateObject private var addCardViewModel = AddCardViewModel()
    @StateObject var noteViewModel:NoteViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Language your learning: ")
                    .padding(.horizontal, 20)
                    .font(.title2)
                    .foregroundColor(Color("CardColor"))
                Picker("Langauge: ", selection: $addCardViewModel.l2Language) {
                    Text("Chinese").tag("zh-CN")
                    Text("US English").tag("en-US")
                    Text("French").tag("fr-FR")
                    Text("Spanish").tag("es-ES")
                    Text("German").tag("de-DE")
                    Text("Italian").tag("it-IT")
                    Text("Japanese").tag("ja-JP")
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .font(.title)
                
                Text("Word or phrase in your language: ")
                    .padding(.horizontal, 20)
                    .font(.title2)
                    .foregroundColor(Color("CardColor"))
                TextField("", text: $addCardViewModel.l1Word)
                    .foregroundColor(Color("CardColor"))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("CardColor"), lineWidth: 2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                Text("Word or phrase in the language your learning: ")
                    .padding(.horizontal, 20)
                    .font(.title2)
                    .foregroundColor(Color("CardColor"))
                TextField("", text: $addCardViewModel.l2Word)
                    .foregroundColor(Color("CardColor"))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("CardColor"), lineWidth: 2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                Text("Pronuncation (optional): ")
                    .padding(.horizontal, 20)
                    .font(.title2)
                    .foregroundColor(Color("CardColor"))
                TextField(".", text: $addCardViewModel.l2Pronunciation)
                    .foregroundColor(Color("CardColor"))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color("CardColor"), lineWidth: 2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }//VStack
            .onAppear {
                UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color("TextColor"))
            }
            .padding(.top, 30)
            Spacer()
            
            Button {
                if addCardViewModel.checkValidation() {
                    showValidationAlert.toggle()
                } else {
                    addCardViewModel.deckName = noteViewModel.deckName
                    addCardViewModel.addCard()
                    noteViewModel.getCards()
                    noteViewModel.setPositions()
                    noteViewModel.setzIndexes()
                    noteViewModel.setisFlipped()
                    self.presentationMode.wrappedValue.dismiss()
                }
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
            
        }//Vstack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor"))
        .alert(isPresented: $showValidationAlert) {
            Alert(title: Text("Warning!"), message: Text("Selecting a language, Word in your language, Word in language you want to learn are required."), dismissButton: .cancel(Text("OK").foregroundColor(Color("TextColor"))))
        }
       
      
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView(noteViewModel: NoteViewModel())
    }
}
