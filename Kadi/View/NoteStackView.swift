//
//  NoteStackView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import SwiftUI


struct NoteStackView: View {
    @ObservedObject var cards:NoteViewModel
    @StateObject var noteStackViewModel = NoteStackViewModel()
    @State private var startAnimation: Bool = false
    
    var card:Card
    
    var body: some View {
            VStack{
                HStack {
                    Spacer()
                    Button {
                       
                        cards.deleteCard(card: card)
                    } label: {
                        Image(systemName: "x.circle")
                            .font(.title2)
                    }
                    .foregroundColor(Color("TextColor"))
                    .padding()

                }
                Spacer()
                if cards.isFlipped[Int(card.sequenceNumber)] {
                    Text(card.l1Word ?? "")
                        .padding(.horizontal, 5)
                        .foregroundColor(Color("TextColor"))
                        .font(Font.custom("HanziPenSC", size: 22))
                        .kerning(-2)
                        .lineLimit(3)
                } else {
                    Text(card.l2Word ?? "")
                        .padding(.horizontal, 5)
                        .foregroundColor(Color("TextColor"))
                        .font(.custom("HanziPenSC", size: 22, relativeTo: .title2))
                        .kerning(-2)
                        .lineLimit(3)
                    Text(card.l2Pronunciation ?? "")
                        .padding(.horizontal, 5)
                        .foregroundColor(Color("TextColor"))
                        .font(.custom("HanziPenSC", size: 14, relativeTo: .footnote))
                        .kerning(-2)
                        .lineLimit(3)
                        
                }
                
                Spacer ()
                HStack {
                    Button {
                        cards.isFlipped[Int(card.sequenceNumber)].toggle()
                    } label: {
                        Image(systemName: "arrow.uturn.left")
                    }
                    .padding()
                    .font(.title)
                    .tint(Color("TextColor"))
                    
                    Button  {
                        noteStackViewModel.ttsPlay(text: card.l2Word, langauge: card.l2Language)
                    } label: {
                        Image(systemName: "play")
                    }
                    .padding()
                    .font(.title)
                    .tint(Color("TextColor"))

                }
            
            }//VStack
            .frame(width: 250, height: 250)
            .background(Color("CardColor"))
            .clipped()
            .shadow(color: .black, radius: 2, x: 1, y:1)
            .zIndex(cards.zIndexes[Int(card.sequenceNumber)])
            .position((startAnimation ? cards.center :  cards.positions[Int(card.sequenceNumber)]))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        startAnimation = false
                        cards.positions[Int(card.sequenceNumber)] = value.location
                    }
                              )//onchanged
                    .onEnded({ value in
                        cards.showHelp = false
                        startAnimation = true
                        
                        if value.location.x < 100 {
                            DispatchQueue.main.async {
                                cards.flip()
                            }
                        }
                    
                        cards.positions[Int(card.sequenceNumber)] = cards.center
                    })
                
            ) //gesture
            .animation(.easeIn, value: startAnimation)
     
    }
}


