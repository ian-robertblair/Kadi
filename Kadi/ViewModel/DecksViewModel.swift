//
//  DecksViewModel.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import Foundation

@MainActor
class DecksViewModel:ObservableObject {
    @Published var cards = [Deck]()
    @Published var hasFullVersion:Bool = false
    
    init() {
    }
    
    func getDecks() {
        cards = CoreDataManager.shared.getAllDecks()
    }
    
    func deleteDeck(name: String) {
        CoreDataManager.shared.deleteDeckByName(deck: name)
        cards = CoreDataManager.shared.getAllDecks()
    }
    
    func canAddDeck() -> Bool {
        guard !self.hasFullVersion else {
            return true
        }
        
        guard CoreDataManager.shared.deckCount() <= 9 else {
            return false
        }
        
        return true
      
    }
}
