//
//  NoteView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import SwiftUI

struct NoteView: View {
    @StateObject private var cards:NoteViewModel = NoteViewModel()
    @State private var startAnimation: Bool = false
    @State private var showAddCardView: Bool = false
    @State private var center:CGPoint = CGPoint()
    let deckName: String
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        VStack {
                        
                        }
                        .frame(width: 250, height: 250)
                        .background(Color("CardColor"))
                        .rotationEffect(.degrees(-3))
                        .position(center)
                        .zIndex(0)
                
                        ForEach(cards.deck) { card in
                            NoteStackView(cards: cards, center: center, card: card)
                            
                        } //For
                    }//ZStack
                    .onAppear {
                        center = CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY - 50)
                        cards.deckName = self.deckName
                        cards.center = center
                        print(center.debugDescription)
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
                    .padding(.bottom, 20)
                }
            }
        } //Navigation
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(deckName: "Sports")
    }
}
