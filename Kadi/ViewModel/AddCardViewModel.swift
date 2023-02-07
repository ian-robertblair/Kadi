//
//  AddCardViewModel.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import Foundation

@MainActor
class AddCardViewModel: ObservableObject {
    @Published var l1Word: String = ""
    @Published var l2Word: String = ""
    @Published var l2Language: String = "zh-CN"
    @Published var l2Pronunciation: String = ""
    var deckName:String = String()
    
    init() {
        
    }
    
    func addCard() {
        //
        if let deck = CoreDataManager.shared.getDeckByName(deck: deckName) {
            CoreDataManager.shared.saveCard(l1Word: l1Word, l2Word: l2Word, l2Pronunciation: l2Pronunciation, l2Language: l2Language, deck: deck)
        }
    }
    
    func checkValidation() -> Bool {
        return  l1Word.isEmpty || l2Word.isEmpty || l2Language.isEmpty
    }
}
