//
//  DeckIconView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/26.
//

import SwiftUI

struct DeckIconView: View {
    let name:String
    @ObservedObject var decksViewModel: DecksViewModel
    @State var showConfirmation:Bool = false
    
    var body: some View {
        ZStack {
            Button {
                showConfirmation.toggle()
                
                
            } label: {
                Image(systemName: "x.circle")
            }
            .zIndex(3)
            .offset(x: 55, y: -60)
            .foregroundColor(Color("TextColor"))
            .font(.body)
            .confirmationDialog("Delete deck?", isPresented: $showConfirmation, titleVisibility: .visible) {
                Button("Yes", role: .destructive) {
                    decksViewModel.deleteDeck(name: name)
                }
                
            }

            VStack {
            
            }
            .frame(width: 150, height: 150)
            .background(Color("CardColor"))
            .rotationEffect(.degrees(-3))
            .zIndex(0)
            
            VStack {
                Text(name)
                    .padding(.horizontal, 5)
                    .foregroundColor(Color("TextColor"))
                    .font(.custom("HanziPenSC", size: 20))
                    .kerning(-2)
                    .lineLimit(3)
            }
            .frame(width: 150, height: 150)
            .background(Color("CardColor"))
            .clipped()
            .shadow(color: .black, radius: 2, x: 1, y:1)
            .zIndex(1)
        }//ZStack
    }
}

struct DeckIconView_Previews: PreviewProvider {
    static var previews: some View {
        DeckIconView(name: "Restaurants and Eating at fancy places.", decksViewModel: DecksViewModel())
    }
}
