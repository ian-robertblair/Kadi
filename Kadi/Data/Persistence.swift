//
//  Persistence.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Kadi")
        persistentContainer.loadPersistentStores { desciption, error in
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func saveDeck(name: String) {
        let context = persistentContainer.viewContext
        let deck = Deck(context: context)
        let id = UUID()
        
        deck.id = id
        deck.name = name
        
        do {
            try context.save()
            print("Saved...")
        } catch {
            print("Failed to save Deck: \(error.localizedDescription)")
        }
        
    }
    
    func saveCard(l1Word: String, l2Word: String, l2Pronunciation: String?, l2Language: String, deck: Deck) {
        let context = persistentContainer.viewContext
        let card = Card(context: context)
        
        let id = UUID()
        card.id = id
        card.l1Word = l1Word
        card.l2Word = l2Word
        card.l2Pronunciation = l2Pronunciation
        card.l2Language = l2Language
        if let temp = getAllCards(deck: deck) {
            card.sequenceNumber = Int16(temp.count)
        } else {
            card.sequenceNumber = 0
        }
        card.deck = deck
    
        do {
            try context.save()
            print("Saved...")
        } catch {
            print("Failed to save Card: \(error.localizedDescription)")
        }
        
    }
    
    func getAllDecks() -> [Deck] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func getAllCards(deck: Deck) -> [Card]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "deck = %@", deck)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Problem fetching cards...")
            return nil
        }
    }
    
    func getDeckByName(deck: String) -> Deck? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", deck)
        
        do {
            let results = try context.fetch(fetchRequest)
            print("Got deck \(results.first.debugDescription)")
            return results.first
        } catch {
            print("Problem fetching deck...")
            return nil
        }
    }
    
    func deleteDeckByName(deck: String) {
        let context = persistentContainer.viewContext
        
        let deckObj = getDeckByName(deck: deck)
        
        if let deckObj = deckObj {
            context.delete(deckObj)
        }
        
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failed to delete deck \(error.localizedDescription)")
        }
    }
    
    func delete(card: Card) {
        let context = persistentContainer.viewContext
        context.delete(card)
        
        do {
            try context.save()
            print("Card deleted...")
        } catch {
            context.rollback()
            print("Failed to delete card \(error.localizedDescription)")
        }
    }
    
    func deckCount() -> Int {
        let context = persistentContainer.viewContext
        var count = 0
        let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            count = results.count
        } catch {
            print("Problem counting decks...")
        }
        
        return count
    }
    
}
