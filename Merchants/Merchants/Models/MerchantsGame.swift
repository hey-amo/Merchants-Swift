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
 v60 good cards in 6 different colours (in 6 colours: white, blue, red, green, yellow, brown)
 
 - 10x White, 10x Red, 10x Green, 10x Yellow, 10x Brown

 30 good cubes in 6 different colours
     - 5x White, 5x Red, 5x Green, 5x Yellow, 5x Brown

 22 special cards
     - 14x ship
     - 2x office
     - 2x warehouse
     - 2x forklift
     - 2x crane
*/

enum CubeColour: Int {
    case none = -1, white, blue, green, yellow, brown
}

class GoodsCard {
    private let goodsColour: CubeColour
    
    init(goodsColour: CubeColour) {
        self.goodsColour = goodsColour
    }
}

class Ship {
    var cubeColor: CubeColour
    
    init(cubeColor: CubeColour) {
        self.cubeColor = cubeColor
    }
}

// Main game model
class MerchantsGame {
    var drawPile: [GoodsCard]
    var player: [Player]
    
    init(drawPile: [GoodsCard], player: [Player]) {
        self.drawPile = drawPile
        self.player = player
    }
}

class Player: NSObject, GKGameModelPlayer {
    var playerId: Int
    var coins: Int
    var hand:[Int] // cards
    
    init(playerId: Int, coins: Int, hand: [Int]) {
        self.playerId = playerId
        self.coins = coins
        self.hand = hand
    }
}
