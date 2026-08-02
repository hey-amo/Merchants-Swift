//
//  Player.swift
//  Merchants
//
//  Created by Amarjit on 31/07/2026.
//

import Foundation
import GameplayKit


class Player: NSObject, GKGameModelPlayer, Codable {
    var playerId: Int
    var coins: Int
    var hand: [CubeColour] // hand of good cards
    var tableau: [BuildingDefinition] = [] // buildings owned by the player
    var cubes: [CubeColour] // cubes in possession
    var isOnTurn: Bool
    var isAI: Bool
    var isStartPlayer: Bool = false
    var avatar: String
    
    init(playerId: Int, coins: Int, hand: [CubeColour] = [], tableau: [BuildingDefinition] = [], cubes: [CubeColour] = [], isAI: Bool = false, isOnTurn: Bool = false, avatar: String = "", isStartPlayer: Bool = false) {
        self.playerId = playerId
        self.coins = coins
        self.hand = hand
        self.tableau = tableau
        self.cubes = cubes
        self.isAI = isAI
        self.isOnTurn = isOnTurn
        self.avatar = avatar
        self.isStartPlayer = isStartPlayer
    }

    func updateCoins(by amount: Int = 0) {
        coins += amount
    }

    func updateHand(with cubes: [CubeColour]) {
        // #TODO: Use hand manager to update
        guard hand.count + cubes.count <= maxHandSize else {
            print("Cannot add card to hand: exceeds maximum hand size.")
            return
        }
        hand.append(contentsOf: cubes)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Player(playerId: playerId, coins: coins, hand: hand, tableau: tableau, cubes: cubes, isAI: isAI, isOnTurn: isOnTurn, avatar: avatar, isStartPlayer: isStartPlayer)
    }
}
