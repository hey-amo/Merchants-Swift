//
//  PlayerSelectScreen.swift
//  Merchants
//
//  Created by Amarjit on 02/07/2026.
//

import SwiftUI

// Route: New game -> Select player -> Select cubes -> Play the game

struct PlayerSelectScreen: View {
    let onStartGame: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("Player select screen")
            Button("Start game", action: onStartGame)
        }
    }
}

#Preview {
    PlayerSelectScreen(onStartGame: {})
}
