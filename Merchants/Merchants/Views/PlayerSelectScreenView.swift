//
//  PlayerSelectScreenView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI
import Foundation
import MerchantsEngine

// Screen to set each of the 4 fixed players to Human or AI
// The game cannot start if all players are AI (must have at least one Human)
struct PlayerSelectScreenView: View {
    public struct PlayerSlot: Identifiable {
        let id: Int
        let displayName: String
        let imageName: String
        var isHuman: Bool
    }

    @State private var players: [PlayerSlot] = [
        .init(id: 0, displayName: "Yellow", imageName: "player-yellow", isHuman: true),
        .init(id: 1, displayName: "Red", imageName: "player-red", isHuman: false),
        .init(id: 2, displayName: "Blue", imageName: "player-blue", isHuman: false),
        .init(id: 3, displayName: "Purple", imageName: "player-purple", isHuman: false)
    ]

    private var isAllAI: Bool {
        players.allSatisfy { !$0.isHuman }
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Select your player")
                .font(.title2)
                .bold()

            // Show the 4 fixed avatars; color images cannot be changed
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach($players) { $player in
                    PlayerCard(player: $player)
                }
            }

            VStack(spacing: 6) {
                Text(isAllAI ? "At least one player must be Human" : "Ready to play solo, or pass-and-play")
                    .font(.footnote)
                    .foregroundColor(isAllAI ? .red : .secondary)

                Button(action: {
                    // Integrate with engine start once available
                    print("Pressed: Play with players: \(players.map { $0.isHuman ? "Human" : "AI" })")
                }) {
                    Text("Play")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isAllAI ? Color.gray.opacity(0.4) : Color.blue.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(isAllAI)
            }
        }
        .padding()
    }
}

private struct PlayerCard: View {
    @Binding var player: PlayerSelectScreenView.PlayerSlot

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(player.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)

                // Green tick for players that will be controlled by a Human
                if player.isHuman {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .imageScale(.large)
                        .padding(6)
                }
            }

            Text(player.displayName)
                .font(.headline)

            Picker("Control", selection: $player.isHuman) {
                Text("AI").tag(false)
                Text("Human").tag(true)
            }
            .pickerStyle(.segmented)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    PlayerSelectScreenView()
}
