//
//  TextToSpeech.swift
//  Kadi
//
//  Created by ian robert blair on 2023/1/25.
//

import Foundation
import Speech

func ttsPlay(text: String?, langauge: String?) {
    let speechSynth = AVSpeechSynthesizer()
    
    let utterance = AVSpeechUtterance(string: text ?? "No word provided.")
    utterance.rate = 0.4
    utterance.voice = AVSpeechSynthesisVoice(language: langauge ?? "en-US")
    speechSynth.speak(utterance)
    
}

