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
    let cardsInHand: Int
}

struct PlayerAvatarRowView: View {
    // Dummy data for preview/testing
    let players: [PlayerInfo] = [
        PlayerInfo(avatar: .playerBlue, coins: 99, isOnTurn: true, playerNumber: 1, cardsInHand: 3),
        PlayerInfo(avatar: .playerRed, coins: 8, isOnTurn: false, playerNumber: 2, cardsInHand: 0),
        PlayerInfo(avatar: .playerGreen, coins: 15, isOnTurn: false, playerNumber: 3, cardsInHand: 8),
        PlayerInfo(avatar: .playerYellow, coins: 10, isOnTurn: false, playerNumber: 4, cardsInHand: 1)
    ]
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(players, id: \.playerNumber) { player in
                Button(action: {
                    print("Player \(player.playerNumber) avatar tapped")
                }) {
                    VStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemGray6))
                                .frame(width: 76, height: 96)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(player.isOnTurn ? Color.blue : Color(.systemGray4), lineWidth: player.isOnTurn ? 3 : 1)
                                )

                            VStack(spacing: 8) {
                                PlayerAvatarView(avatar: player.avatar, size: 48)

                                HStack(spacing:6) {
                                    Text("£\(player.coins)")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundColor(player.isOnTurn ? .primary : .secondary)
                                        .monospacedDigit()
                                                    
                                         // Display how many cards they have
                                    Text("🂠 \(player.cardsInHand)").font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundColor(player.isOnTurn ? .primary : .secondary)
                                        .monospacedDigit()
                                }
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .accessibilityLabel("Player \(player.playerNumber), coins £\(player.coins)\(player.isOnTurn ? ", on turn" : "")")
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PlayerAvatarRowView()
}
