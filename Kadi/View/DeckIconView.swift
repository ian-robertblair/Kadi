//
//  DeckIconView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/26.
//

import SwiftUI

struct DeckIconView: View {
    let name:String
    let decksViewModel: DecksViewModel
    
    var body: some View {
        ZStack {
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
            .contextMenu {
                Button {
                    decksViewModel.deleteDeck(name: name)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            
        }//ZStack
    }
}

struct DeckIconView_Previews: PreviewProvider {
    static var previews: some View {
        DeckIconView(name: "Restaurants and Eating at fancy places.", decksViewModel: DecksViewModel())
    }
}
