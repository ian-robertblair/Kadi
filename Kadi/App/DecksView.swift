//
//  DecksView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import SwiftUI

struct DecksView: View {
    @StateObject private var decksViewModel = DecksViewModel()
    @State private var showAddDeckView:Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(decksViewModel.cards) { deck in
                    NavigationLink {
                        //
                        NoteView(deckName: deck.name ?? "")
                    } label: {
                        Text(deck.name ?? "")
                            //.padding(.top, 20)
                    }
                    .foregroundColor(Color("TextColor"))
                    //.tint(Color("TextColor"))
                }//For
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.clear)
                
            }//List
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $showAddDeckView, content: {
                AddDeckView(decksViewModel: decksViewModel)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))
            .onAppear {
                decksViewModel.getDecks()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                        showAddDeckView.toggle()
                    } label: {
                        
                        Image(systemName: "plus.circle")
                    }
                    .tint(Color("CardColor"))
                    .font(.title)
                    .padding()
                    
                }
            }//toolbar
        }//Nav
    }//View
}

struct DecksView_Previews: PreviewProvider {
    static var previews: some View {
        DecksView()
    }
}
