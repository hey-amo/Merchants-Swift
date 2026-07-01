//
//  MerchantsGame.swift
//  Merchants
//
//  Created by Amarjit on 29/06/2026.
//
import GameplayKit
import Foundation

enum State: Int, CaseIterable, Codable {
    case idle, busy, thinking, action
}

/* 
 60 good cards in 6 different colours (white, blue, red, green, yellow, brown)
 - 10x White, 10x Blue, 10x Red, 10x Green, 10x Yellow, 10x Brown

 30 good cubes in 6 different colours
     - 5x White, 5x Blue, 5x Red, 5x Green, 5x Yellow, 5x Brown

 16 special cards
     - 14x ship - each player starts with 1 ship, some ships hold 1 cube, some 2
     - 2x office - makes 1 more coin per 2 cubes sold
     - 2x crane
*/

enum CubeColour: Int, CaseIterable {
    case white, blue, red, green, yellow, brown
}

extension CubeColour {
    static func makePile(count: Int) -> [CubeColour] {
        CubeColour.allCases.flatMap { color in
            Array(repeating: color, count: count)
        }
    }
}

// Main game model
class MerchantsGame {
    var currentState: State = .idle
    var drawPile: [CubeColour]
    var cubePile: [CubeColour]
    var players: [Player]
    var currentPlayerIndex: Int = 0
    
    //var gameMessageHandler: GameMessageHandling = GameMessageHandler()
    
    init(drawPile: [CubeColour], cubePile: [CubeColour], players: [Player]) {
        self.drawPile = drawPile
        self.cubePile = cubePile
        self.players = players
    }

    func newGame(players: [Player]) {
        self.players = players
        self.drawPile = CubeColour.makePile(count: 10)
        self.cubePile = CubeColour.makePile(count: 5)
    }
}

class Player: NSObject, GKGameModelPlayer {
    var playerId: Int
    var coins: Int
    var hand: [CubeColour] // hand of good cards
    var cubes: [CubeColour] // cubes in possession
    var isOnTurn: Bool
    var isAI: Bool
    
    init(playerId: Int, coins: Int, hand: [CubeColour] = [], cubes: [CubeColour] = [], isAI: Bool = false, isOnTurn: Bool = false) {
        self.playerId = playerId
        self.coins = coins
        self.hand = hand
        self.cubes = cubes
        self.isAI = isAI
        self.isOnTurn = isOnTurn
    }

    func updateCoins(by amount: Int = 0) {
        coins += amount
    }

    func updateHand(with cubes: [CubeColour]) {
        guard hand.count + cubes.count <= 6 else {
            print("Cannot add card to hand: exceeds maximum hand size.")
            return
        }
        hand.append(contentsOf: cubes)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Player(playerId: playerId, coins: coins, hand: hand, cubes: cubes, isAI: isAI, isOnTurn: isOnTurn)
    }
}
