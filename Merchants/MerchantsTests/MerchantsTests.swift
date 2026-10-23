//
//  MerchantsTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 29/06/2026.
//

import XCTest
@testable import Merchants

final class MerchantsTests: XCTestCase {
    
    func testNewGameCreation() throws {
        let game = MerchantsGame(buildings: [], drawPile: [], cubePile: [], players: [])

        let dummyPlayers: [Player] = [
            Player(playerId: 1, coins: 0),
            Player(playerId: 2, coins: 0)
        ]

        let setup = game.makeDefaultGameSetup()

        XCTAssertEqual(setup.drawPile.count, GameConstants.totalGoodCards) // expect 60 good cards
        XCTAssertEqual(setup.cubePile.count, GameConstants.cubeCount) // expect 30 good cubes
        XCTAssertEqual(setup.marketplace.count, 0) // expect 0 cards in marketplace

        let cardCounts = Dictionary(grouping: setup.drawPile, by: { $0 })
            .mapValues { $0.count }
        let cubeCounts = Dictionary(grouping: setup.cubePile, by: { $0 })
            .mapValues { $0.count }

        for color in GoodsCube.allCases {
            XCTAssertEqual(cardCounts[color], 10) // expect 10 of each good card
            XCTAssertEqual(cubeCounts[color], 5)  // expect 5 of each good cube
        }

        game.newGame(players: dummyPlayers)

        XCTAssertEqual(game.drawPile.count, GameConstants.totalGoodCards - (dummyPlayers.count * 3) - GameConstants.marketplaceSize)
        XCTAssertEqual(game.cubePile.count, GameConstants.cubeCount)
        XCTAssertEqual(game.marketplace.count, GameConstants.marketplaceSize)
    }

    func testBuildingDefinitionsCreateExpectedDeck() throws {
        let deck = BuildingDefinition.makeDeck()

        XCTAssertEqual(deck.count, 20)
    }

}
