//
//  Canvas.swift
//  Merchants
//
//  Created by Amarjit on 02/07/2026.
//

import Foundation
import SwiftUI

struct GameCanvas: View {
    let players: [Player]
    let activePlayerID: Int?

    init(players: [Player], activePlayerID: Int? = nil) {
        self.players = players
        self.activePlayerID = activePlayerID
    }

    var body: some View {
        VStack(spacing: 0) {
            GameHeaderView(players: players, activePlayerID: activePlayerID)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemBackground))
    }
}

#Preview {
    GameCanvas(
        players: [
            Player(playerId: 1, coins: 0, avatar: AvatarResource.avt1.rawValue),
            Player(playerId: 2, coins: 0, avatar: AvatarResource.avt2.rawValue),
            Player(playerId: 3, coins: 0, avatar: AvatarResource.avt3.rawValue),
            Player(playerId: 4, coins: 0, avatar: AvatarResource.avt4.rawValue)
        ],
        activePlayerID: 1
    )
}
