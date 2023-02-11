//
//  NotesViewModel.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import Foundation
import Speech


@MainActor
class NoteViewModel:ObservableObject {
    var deckName: String = String()
    @Published var deck:[Card] = [Card]()
    @Published var zIndexes = [Double]()
    @Published var positions = [CGPoint]()
    @Published var isFlipped = [Bool]()
    @Published var center = CGPoint()
    @Published var startAnimation: Bool = false
    @Published var showAddCardView: Bool = false
    @Published var showHelp: Bool = true
  
    init() {
        
    }
    
    func getCards() {
        
        if let deckObj = CoreDataManager.shared.getDeckByName(deck: deckName) {
            if let deck = CoreDataManager.shared.getAllCards(deck: deckObj) {
                self.deck = deck
            }
        }
        
       
    }
    
    func setisFlipped() {
        isFlipped.removeAll()
        for _ in deck {
            isFlipped.append(false)
        }
        
       
    }
    
    func setzIndexes() {
        zIndexes.removeAll()
        var count = deck.count
        for _ in deck {
            count -= 1
            zIndexes.append(Double(count))
            
        }
        
       
    }
    
    func setPositions() {
        positions.removeAll()
        for _ in deck {
            positions.append(center)
           
        }
    }
    
    
    func deleteCard(card: Card) {
        CoreDataManager.shared.delete(card: card)
        getCards()
    }
    
    func flip() {
       
            let temp = zIndexes.removeLast()
            zIndexes.insert(temp, at: 0)
            
        }
}

