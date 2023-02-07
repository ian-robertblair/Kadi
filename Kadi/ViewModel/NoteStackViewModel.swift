//
//  NoteStackViewModel.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import Foundation
import Speech

@MainActor
class NoteStackViewModel: ObservableObject {
    var speechSynth = AVSpeechSynthesizer()
    
    
    func ttsPlay(text: String?, langauge: String?) {
        
        
        let utterance = AVSpeechUtterance(string: text ?? "No word provided.")
        utterance.rate = 0.4
        utterance.voice = AVSpeechSynthesisVoice(language: langauge ?? "en-US")
        utterance.volume = 1.0
        speechSynth.speak(utterance)
        
    }

}
