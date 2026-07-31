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

struct TurnPhase: Equatable, Codable {
    let id: String
    let name: String
    let actions: [TurnAction]
}

struct TurnAction: Equatable, Codable {
    let id: String
    let name: String
}


// Phase 1: Exchange goods cube, Buy building, Pass
// Phase 2: Play good cards, Draw good cards, End turn
extension TurnPhase {
    static let phase1 = TurnPhase(
        id: "phase1",
        name: "Phase 1",
        actions: [
            TurnAction(id: "exchangeGoodsCube", name: "Exchange goods cube"),
            TurnAction(id: "buyBuilding", name: "Buy building"),
            TurnAction(id: "pass", name: "Pass")
        ]
    )

    static let phase2 = TurnPhase(
        id: "phase2",
        name: "Phase 2",
        actions: [
            TurnAction(id: "playGoodCards", name: "Play good cards"),
            TurnAction(id: "drawGoodCards", name: "Draw good cards"),
            TurnAction(id: "endTurn", name: "End turn")
        ]
    )
}

/* 
 60 good cards in 6 different colours (white, blue, red, green, yellow, brown)
 - 10x White, 10x Blue, 10x Red, 10x Green, 10x Yellow, 10x Brown

 30 good cubes in 6 different colours
     - 5x White, 5x Blue, 5x Red, 5x Green, 5x Yellow, 5x Brown

 16 building cards
     - 14x ship (10 coins) - each player starts with 1 ship. Each ship can carry 1 goods cube. After purchasing a ship, the player immediatley takes a goods cube and places it on the purchased ship.
     - 2x office (8 coins) - makes 1 more coin
     - 2x crane (12 coins) - allows a player to exchange 1 extra goods cube in phase 1
     - 2x warehouse (10 coins) - allows a player to take 1 more card in phase 1
*/

enum CubeColour: Int, CaseIterable, Codable {
    case white, blue, red, green, yellow, brown
}

extension CubeColour {
    static func makePile(count: Int) -> [CubeColour] {
        CubeColour.allCases.flatMap { color in
            Array(repeating: color, count: count)
        }
    }
}

struct BuildingDefinition: Equatable, Codable {
    let name: String
    let details: String
    let cost: Int
    let cubeCapacity: Int
    let cubeSlots: [CubeColour]
    let quantity: Int

    init(name: String, details: String, cost: Int, cubeCapacity: Int = 0, cubeSlots: [CubeColour] = [], quantity: Int = 1) {
        self.name = name
        self.details = details
        self.cost = cost
        self.cubeCapacity = cubeCapacity
        self.cubeSlots = cubeSlots
        self.quantity = quantity
    }
}

extension BuildingDefinition {
    static func makeDeck() -> [BuildingDefinition] {
        [
            BuildingDefinition(name: "Ship", details: "Each ship can hold 1 goods cube. After purchasing a ship, the player immediately takes a goods cube and places it on the ship.", cost: 10, cubeCapacity: 1, cubeSlots: [], quantity: 10),
            BuildingDefinition(name: "Large Ship", details: "Each ship can hold 2 goods cubes. After purchasing a ship, the player immediately takes a goods cube and places it on the ship.", cost: 25, cubeCapacity: 2, cubeSlots: [], quantity: 4),
            BuildingDefinition(name: "Office", details: "Generates 1 additional coin when you deliver good cards.", cost: 8, quantity: 2),
            BuildingDefinition(name: "Crane", details: "Allows a player to exchange 1 extra goods cube during Phase 1.", cost: 12, quantity: 2),
            BuildingDefinition(name: "Warehouse", details: "Allows a player to draw 1 additional card during Phase 1.", cost: 10, quantity: 2)
        ].flatMap { definition in
            Array(repeating: definition, count: definition.quantity)
        }
    }
}

// Main game model
class MerchantsGame {
    var currentState: State = .idle
    var buildings: [BuildingDefinition] = []
    var drawPile: [CubeColour]
    var cubePile: [CubeColour]
    var marketplace: [CubeColour] = [] // cards delivered to the marketplace 6 cards max
    var players: [Player]
    var currentPlayerIndex: Int = 0
    
    //var gameMessageHandler: GameMessageHandling = GameMessageHandler()
    
    init(buildings: [BuildingDefinition], drawPile: [CubeColour], cubePile: [CubeColour], players: [Player], marketplace: [CubeColour] = []) {
        self.buildings = buildings
        self.drawPile = drawPile
        self.cubePile = cubePile
        self.players = players
        self.marketplace = marketplace
    }

    func newGame(players: [Player]) {
        self.players = players
        self.drawPile = CubeColour.makePile(count: 10)
        self.drawPile.shuffle()
        self.cubePile = CubeColour.makePile(count: 5)
        self.marketplace = [] // marketplace starts empty
        // reset players' hands and cubes and coins
        for player in self.players {
            player.hand = []
            player.cubes = []
            player.coins = 0
        }
        // draw 3 cards for each player from drawPile
        for player in self.players {
            let cardsToDraw = min(3, drawPile.count)
            let drawnCards = drawPile.prefix(cardsToDraw)
            player.hand.append(contentsOf: drawnCards)
            drawPile.removeFirst(cardsToDraw)
        }
        // give each player 2 ship cards (they cannot be large ships)
        // they are empty ships, because we do a snake draft
        for player in self.players {
            let shipCards = buildings.filter { $0.name == "Ship" }.prefix(2)
            // remove the ship cards from the buildings pile
            for ship in shipCards {
                if let index = buildings.firstIndex(of: ship) {
                    buildings.remove(at: index)
                }
                player.tableau.append(ship)
            }            
        }
        // fill the marketplace with 6 cards from the drawPile
        let cardsToDrawForMarketplace = min(6, drawPile.count)
        let drawnCardsForMarketplace = drawPile.prefix(cardsToDrawForMarketplace)
        marketplace.append(contentsOf: drawnCardsForMarketplace)
        drawPile.removeFirst(cardsToDrawForMarketplace)
    }
}
