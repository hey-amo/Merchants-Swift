//
//  PlayerSelectScreen.swift
//  Merchants
//
//  Created by Amarjit on 02/07/2026.
//

import SwiftUI

struct Player {
    let id: Int
    let avatarName: String
    var isHuman: Bool = true
}

struct PlayerSelectScreen: View {
    @State private var players: [Player] = []
    @State private var selectedPlayerCount: Int = 3
    
    private let minPlayers = 3
    private let maxPlayers = 5
    private let avatarNames = ["avt-1", "avt-2", "avt-3", "avt-4", "avt-5"]
    
    var humanPlayerCount: Int {
        players.filter { $0.isHuman }.count
    }
    
    var isPlayValid: Bool {
        players.count >= minPlayers && 
        players.count <= maxPlayers && 
        humanPlayerCount >= 1
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Select Players")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Choose between \(minPlayers)-\(maxPlayers) players")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Player Count Selector
                VStack(spacing: 12) {
                    Text("Number of Players: \(selectedPlayerCount)")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Slider(value: .init(get: { Double(selectedPlayerCount) }, set: { selectedPlayerCount = Int($0) }), 
                           in: Double(minPlayers)...Double(maxPlayers), 
                           step: 1.0)
                    .tint(.blue)
                    .onChange(of: selectedPlayerCount) { oldValue, newValue in
                        updatePlayers()
                    }
                }
                .padding(.horizontal, 20)
                
                // Player Cards
                VStack(spacing: 16) {
                    ForEach(0..<players.count, id: \.self) { index in
                        PlayerCard(
                            player: $players[index],
                            avatarName: players[index].avatarName,
                            index: index + 1
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Human Player Count Info
                HStack(spacing: 8) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(humanPlayerCount >= 1 ? .green : .red)
                    
                    Text("Human Players: \(humanPlayerCount)/\(selectedPlayerCount)")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(humanPlayerCount >= 1 ? .primary : .red)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                
                // Play Button
                Button(action: {
                    // Start game
                }) {
                    Text("Play")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .foregroundColor(.white)
                        .background(isPlayValid ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!isPlayValid)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            updatePlayers()
        }
    }
    
    private func updatePlayers() {
        var newPlayers: [Player] = []
        for i in 0..<selectedPlayerCount {
            let avatarName = avatarNames[i % avatarNames.count]
            if i < players.count {
                newPlayers.append(players[i])
            } else {
                newPlayers.append(Player(id: i, avatarName: avatarName, isHuman: true))
            }
        }
        players = newPlayers
    }
}

struct PlayerCard: View {
    @Binding var player: Player
    let avatarName: String
    let index: Int
    
    var body: some View {
        VStack(spacing: 12) {
            // Avatar
            Image(avatarName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(player.isHuman ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                )
            
            // Player Number
            Text("Player \(index)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
            
            // Toggle
            HStack(spacing: 8) {
                Button(action: { player.isHuman = true }) {
                    Text("Human")
                        .font(.system(size: 12, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(player.isHuman ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                        .foregroundColor(player.isHuman ? .blue : .secondary)
                        .cornerRadius(8)
                }
                
                Button(action: { player.isHuman = false }) {
                    Text("AI")
                        .font(.system(size: 12, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(!player.isHuman ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                        .foregroundColor(!player.isHuman ? .blue : .secondary)
                        .cornerRadius(8)
                }
            }
            .frame(height: 32)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

#Preview {
    PlayerSelectScreen()
}
