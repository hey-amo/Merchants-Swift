//
//  AudioTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 01/08/2026.
//

import XCTest
@testable import Merchants

final class AudioTests: XCTestCase {

    func testInit_UsesDefaultPreferences() {
        let preferences = AudioPreferences()

        XCTAssertTrue(preferences.musicVolume)
        XCTAssertFalse(preferences.soundVolume)
    }

    func testExecute_SoundConfigurationPreservesMusicPreference() {
        let preferences = AudioPreferences(musicVolume: false, soundVolume: false)

        let configured = preferences.execute(.sound(on: true))

        XCTAssertFalse(configured.musicVolume)
        XCTAssertTrue(configured.soundVolume)
    }

    func testExecute_MusicConfigurationPreservesSoundPreference() {
        let preferences = AudioPreferences(musicVolume: true, soundVolume: true)

        let configured = preferences.execute(.music(on: false))

        XCTAssertFalse(configured.musicVolume)
        XCTAssertTrue(configured.soundVolume)
    }

    func testCodable_RoundTripsPreferences() throws {
        let preferences = AudioPreferences(musicVolume: false, soundVolume: true)

        let data = try JSONEncoder().encode(preferences)
        let decoded = try JSONDecoder().decode(AudioPreferences.self, from: data)

        XCTAssertEqual(decoded, preferences)
    }

    func testDecode_MissingPreferenceThrows() {
        let data = Data("{\"musicVolume\":true}".utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(AudioPreferences.self, from: data))
    }
}