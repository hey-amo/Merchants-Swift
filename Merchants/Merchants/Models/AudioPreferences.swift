//
//  AudioPreferences.swift
//  Merchants
//
//  Created by Amarjit on 31/07/2026.
//

struct AudioPreferences: Codable, Hashable {
    let musicVolume: Double
    let soundVolume: Double
    
    init(musicVolume: Double = 0.7, soundVolume: Double = 0.7) {
        self.musicVolume = musicVolume
        self.soundVolume = soundVolume
    }
    
    enum Configure {
        case sound(amount: Double)
        case music(amount: Double)
    }
    
    func execute(_ configuration: Configure) -> Self {
        switch configuration {
        case .sound(let amount):
            return .init(musicVolume: musicVolume, soundVolume: amount)
        case .music(let amount):
            return .init(musicVolume: amount, soundVolume: soundVolume)
        }
    }
}


extension AudioPreferences {
    func save() {
        
    }
    
    func load() {
        
    }
}
