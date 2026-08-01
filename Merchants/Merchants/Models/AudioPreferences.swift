//
//  AudioPreferences.swift
//  Merchants
//
//  Created by Amarjit on 31/07/2026.
//

struct AudioPreferences: Codable, Hashable {
    let musicVolume: Bool
    let soundVolume: Bool
    
    init(musicVolume: Bool = true, soundVolume: Bool = false) {
        self.musicVolume = musicVolume
        self.soundVolume = soundVolume
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.musicVolume = try container.decode(Bool.self, forKey: .musicVolume)
        self.soundVolume = try container.decode(Bool.self, forKey: .soundVolume)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(musicVolume, forKey: .musicVolume)
        try container.encode(soundVolume, forKey: .soundVolume)
    }

    enum Configure {
        case sound(on: Bool)
        case music(on: Bool)
    }
    
    func execute(_ configuration: Configure) -> Self {
        switch configuration {
        case .sound(let on):
            return .init(musicVolume: musicVolume, soundVolume: on)
        case .music(let on):
            return .init(musicVolume: on, soundVolume: soundVolume)
        }
    }
}
