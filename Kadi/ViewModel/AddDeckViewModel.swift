//
//  AddDeckViewModel.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import Foundation

@MainActor
class AddDeckViewModel:ObservableObject {
    @Published var name: String = ""
    
    func addDeck() {
        CoreDataManager.shared.saveDeck(name: name)
    }
}
