//
//  PreferenceTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 29/08/2025.
//

import XCTest
@testable import Merchants

fileprivate enum GameSetting {
    case sound(on: Bool)
    case music(on: Bool)
    
    static func execute(_ p: GameSetting) -> GameSetting {
        switch p {
        case .sound(let sound):
            return GameSetting.sound(on: sound)
        case .music(let music):
            return GameSetting.music(on: music)
        }
    }
    
}

fileprivate struct Preferences {
    let sfx: GameSetting
    let music: GameSetting
}

final class PreferenceTests: XCTestCase {
    
    private var preferences: Preferences!
    
    override func setUpWithError() throws {
        self.preferences = Preferences(sfx: GameSetting.sound(on: true), music: GameSetting.music(on: true))
    }

    public func test_didToggleSFX_toOff() throws {
        // toggle the sound
    }
    
    public func test_didToggleSFX_toOn() throws {
        // toggle the sound
    }
    
    public func test_didToggleMusic_toOff() throws {
    }
    
    public func test_didToggleMusic_toOn() throws {
    }
    
}
