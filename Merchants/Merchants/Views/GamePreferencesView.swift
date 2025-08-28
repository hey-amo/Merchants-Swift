//
//  GamePreferencesView.swift
//  Merchants
//
//  Created by Amarjit on 28/08/2025.
//

import SwiftUI
import MerchantsEngine

struct GamePreferencesView: View {
    @State private var soundEnabled: Bool = true
    @State private var musicEnabled: Bool = true
    @State private var notificationsEnabled: Bool = true
    var body: some View {
        VStack(spacing: 20) {
            Text("Preferences")
                .font(.title2)
                .bold()

            // Sound
            Button(action: {
                soundEnabled.toggle()
                print("Preferences: Sound toggled -> \(soundEnabled ? "ON" : "OFF")")
            }) {
                preferenceButtonLabel(
                    title: "Sound: \(soundEnabled ? "On" : "Off")",
                    systemImage: soundEnabled ? "speaker.wave.2.fill" : "speaker.slash.fill",
                    isOn: soundEnabled,
                    onColor: .blue
                )
            }

            // Music
            Button(action: {
                musicEnabled.toggle()
                print("Preferences: Music toggled -> \(musicEnabled ? "ON" : "OFF")")
            }) {
                preferenceButtonLabel(
                    title: "Music: \(musicEnabled ? "On" : "Off")",
                    systemImage: musicEnabled ? "music.note" : "music.note.slash",
                    isOn: musicEnabled,
                    onColor: .blue
                )
            }

            // Notifications
            Button(action: {
                notificationsEnabled.toggle()
                print("Preferences: Notifications toggled -> \(notificationsEnabled ? "ON" : "OFF")")
            }) {
                preferenceButtonLabel(
                    title: "Notifications: \(notificationsEnabled ? "On" : "Off")",
                    systemImage: notificationsEnabled ? "bell.fill" : "bell.slash.fill",
                    isOn: notificationsEnabled,
                    onColor: .blue
                )
            }

            // Quit Game
            Button(action: {
                print("Preferences: Quit Game pressed")
            }) {
                filledButtonLabel(title: "Quit Game", systemImage: "power", fillColor: .red)
            }
            .padding(.top, 24)
        }
        .padding()
        .controlSize(.large)
    }

    // MARK: - Label Builders

    private func preferenceButtonLabel(title: String, systemImage: String, isOn: Bool, onColor: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(title)
                .fontWeight(.semibold)
        }
        .font(.title3)
        .frame(maxWidth: .infinity, minHeight: 56)
        .foregroundColor(isOn ? .white : onColor)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isOn ? onColor : Color.clear)
        )
        .overlay(
            Group {
                if !isOn {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(onColor, lineWidth: 1.5)
                }
            }
        )
    }

    private func filledButtonLabel(title: String, systemImage: String, fillColor: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
            Text(title)
                .fontWeight(.semibold)
        }
        .font(.title3)
        .frame(maxWidth: .infinity, minHeight: 56)
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(fillColor)
        )
    }
}

#Preview {
    GamePreferencesView()
}
