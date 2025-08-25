//
//  PlayerAvatarRowView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI
import MerchantsEngine

struct PlayerInfo {
    let avatar: Avatar
    let coins: Int
    let isOnTurn: Bool
    let playerNumber: Int
}

struct PlayerAvatarRowView: View {
    // Dummy data for preview/testing
    let players: [PlayerInfo] = [
        PlayerInfo(avatar: .playerBlue, coins: 12, isOnTurn: true, playerNumber: 1),
        PlayerInfo(avatar: .playerRed, coins: 8, isOnTurn: false, playerNumber: 2),
        PlayerInfo(avatar: .playerGreen, coins: 15, isOnTurn: false, playerNumber: 3),
        PlayerInfo(avatar: .playerYellow, coins: 10, isOnTurn: false, playerNumber: 4)
    ]
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(players, id: \.playerNumber) { player in
                Button(action: {
                    print("Player \(player.playerNumber) avatar tapped")
                }) {
                    VStack(spacing: 2) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                                .frame(width: 70, height: 90)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(player.isOnTurn ? Color.blue : Color(.systemGray4), lineWidth: player.isOnTurn ? 3 : 2)
                                )
                            
                            VStack(spacing: 6) {
                                PlayerAvatarView(avatar: player.avatar, size: 48)
                                
                                Text("£\(player.coins)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                            }
                        }
                        // Player name
                        /*Text("Player \(player.playerNumber)")
                            .font(.footnote)
                            .fontWeight(player.isOnTurn ? .bold : .regular)
                            .foregroundColor(player.isOnTurn ? .blue : .primary)*/
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PlayerAvatarRowView()
}
