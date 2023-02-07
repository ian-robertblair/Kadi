//
//  DecksView.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import SwiftUI

struct DecksView: View {
    @StateObject private var decksViewModel = DecksViewModel()
    @StateObject private var storeKitManager = StoreKitManager()
    @State private var showAddDeckView:Bool = false
    @State private var showBuyFullAlert = false
    
    
    var body: some View {
        NavigationView {
         
                let gridItems  = [ GridItem(), GridItem() ]
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: gridItems) {
                        ForEach(decksViewModel.cards) { deck in
                            NavigationLink {
                                //
                                NoteView(deckName: deck.name ?? "")
                            } label: {
                                DeckIconView(name: deck.name ?? "", decksViewModel: decksViewModel)
                                    .padding(.top, 20)
                            }
                            .tint(Color("TextColor"))
                        }//For
                    }//Grid
                }//scroll
                
                .padding()
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
                        //add check
                        if decksViewModel.canAddDeck() {
                            showAddDeckView.toggle()
                        } else {
                            showBuyFullAlert.toggle()
                        }
                    } label: {
                        
                        Image(systemName: "plus.circle")
                    }
                    .tint(Color("CardColor"))
                    .font(.title)
                    .padding()
                }
                if !decksViewModel.hasFullVersion {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            //
                            Task {
                                if let fullVersion = storeKitManager.storeProducts.first {
                                    _ = try await storeKitManager.purchase(fullVersion)
                                }
                               
                                
                            }
                        } label: {
                            Text(storeKitManager.storeProducts.first?.displayName ?? "")
                                .font(.body)
                                .fontWeight(.bold)
                        }
                        
                    }
                } else {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Full Version")
                            .foregroundColor(Color("TextColor"))
                    }
                }
            }//toolbar
        }//Nav
        .onChange(of: storeKitManager.purchasedVersions) { _ in
            Task {
                decksViewModel.hasFullVersion = (try? await storeKitManager.isPurchased(product: storeKitManager.storeProducts.first!)) ?? false
            }
            
        }//onChange
        .alert(isPresented: $showBuyFullAlert) {
            Alert(title: Text("Buy Full Version!"), message: Text("Please buy the full version if you want to add more than 10 decks."), dismissButton: .default(Text("OK")))
        }
    }//View
}

struct DecksView_Previews: PreviewProvider {
    static var previews: some View {
        DecksView()
    }
}
