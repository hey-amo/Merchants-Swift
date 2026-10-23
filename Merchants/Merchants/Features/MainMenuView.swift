//
//  ContentView.swift
//  Merchants
//
//  Created by Amarjit on 29/06/2026.
//

import SwiftUI
//import SwiftData

struct MainMenuView: View {
    @State private var navigation = NavigationHandler()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            VStack {
                Text("Merchants").font(.largeTitle)
                Image("ship-nobg")
                Button("Play") {
                    navigation.push(.playerSelection)
                }
            }
            .navigationDestination(for: Route.self, destination: destination(for:))
        }
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
        case .playerSelection:
            PlayerSelectScreen {
                let players = [
                    Player(playerId: 1, coins: 0),
                    Player(playerId: 2, coins: 0)
                ]
                navigation.push(.game(GameSession(players: players)))
            }
        case .game(let session):
            GameCanvas(
                players: session.players,
                activePlayerID: session.players.first?.playerId,
                onPause: { navigation.push(.pause(session)) },
                onEndGame: { navigation.push(.winner(session)) }
            )
        case .pause:
            PauseMenuScreen(
                onContinue: { navigation.pop() },
                onQuit: { navigation.popToRoot() }
            )
        case .winner(let session):
            WinnerScreenView(players: session.players) {
                navigation.popToRoot()
                navigation.push(.playerSelection)
            }
        }
    }
}

#Preview {
    MainMenuView()
}
