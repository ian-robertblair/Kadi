//
//  NoteView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import SwiftUI

struct NoteView: View {
    @StateObject private var cards:NoteViewModel = NoteViewModel()
    @State private var showAddCardView: Bool = false
    
    let deckName: String
    
    var body: some View {
        //NavigationView {
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        if cards.showHelp {
                            HStack{
                                Image(systemName: "arrow.left")
                                Text("Drag")
                                    .font(Font.custom("HanziPenSC", size: 22))
                            }
                                .zIndex(10)
                                .offset(y: -200)
                                .foregroundColor(Color("CardColor"))
                        }
                    
                        VStack {
                        
                        }
                        .frame(width: 250, height: 250)
                        .background(Color("CardColor"))
                        .rotationEffect(.degrees(-3))
                        .position(cards.center)
                        .zIndex(0)
                
                        ForEach(cards.deck) { card in
                            NoteStackView(cards: cards, card: card)
                            
                        } //For
                    }//ZStack
                    .onAppear {
                        cards.center = CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY - 50)
                        cards.deckName = self.deckName
                        cards.center = cards.center
                        //print(center.debugDescription)
                        cards.getCards()
                        cards.setPositions()
                        cards.setzIndexes()
                        cards.setisFlipped()
                    }
                }//Geometry
                
            }//VStack
            .sheet(isPresented: $showAddCardView, content: {
                AddCardView(noteViewModel: cards)
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddCardView.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .tint(Color("CardColor"))
                    .font(.title)
                    .padding()
                }
            }
        //} //Navigation
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(deckName: "Sports")
    }
}
