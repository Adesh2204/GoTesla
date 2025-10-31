//
//  SpeechRecognizer.swift
//  GoTesla
//
//  Created by Adesh Shukla on 30/06/25.
//

import Foundation
import SwiftUI

// A simplified mock speech recognizer that doesn't actually use speech recognition
// This avoids the crashes related to speech recognition and audio permissions
class SpeechRecognizer: NSObject, ObservableObject {
    @Published var transcript = ""
    @Published var isListening = false
    @Published var hasPermission = true
    
    // Predefined responses for the mock speech recognizer
    private let predefinedResponses = [
        "Play music",
        "Navigate to home",
        "Turn on climate control",
        "Set temperature to 72 degrees",
        "Open sunroof",
        "Lock the car",
        "Check battery status"
    ]
    
    override init() {
        super.init()
    }
    
    func startListening() {
        // Don't start if already listening
        guard !isListening else { return }
        
        DispatchQueue.main.async {
            self.isListening = true
            self.transcript = ""
            
            // Simulate speech recognition with a random predefined response after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if self.isListening {
                    // Select a random predefined response
                    if let response = self.predefinedResponses.randomElement() {
                        self.transcript = response
                    }
                    
                    // Automatically stop listening after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        if self.isListening {
                            self.stopListening()
                        }
                    }
                }
            }
        }
    }
    
    func stopListening() {
        DispatchQueue.main.async {
            self.isListening = false
            // Keep the transcript text
        }
    }
}