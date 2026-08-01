//
//  MerchantsTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 29/06/2026.
//

import XCTest
@testable import Merchants

final class MerchantsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewGameCreation() throws {
        let game = MerchantsGame(buildings: [], drawPile: [], cubePile: [], players: [])

        let dummyPlayers: [Player] = [
            Player(playerId: 1, coins: 0),
            Player(playerId: 2, coins: 0)
        ]
        
        game.newGame(players: dummyPlayers)

        XCTAssertEqual(game.drawPile.count, 60) // expect 60 good cards
        XCTAssertEqual(game.cubePile.count, 30) // expect 30 good cubes
        XCTAssertEqual(game.marketplace.count, 0) // expect 0 cards in marketplace

        let cardCounts = Dictionary(grouping: game.drawPile, by: { $0 })
            .mapValues { $0.count }
        let cubeCounts = Dictionary(grouping: game.cubePile, by: { $0 })
            .mapValues { $0.count }

        for color in CubeColour.allCases {
            XCTAssertEqual(cardCounts[color], 10) // expect 10 of each good card
            XCTAssertEqual(cubeCounts[color], 5)  // expect 5 of each good cube
        }
    }

    func testBuildingDefinitionsCreateExpectedDeck() throws {
        let deck = BuildingDefinition.makeDeck()

        XCTAssertEqual(deck.count, 20)
        XCTAssertEqual(deck.filter { $0.name == "Ship" }.count, CardConstants.shipCardsCount)
        XCTAssertEqual(deck.filter { $0.name == "Large Ship" }.count, CardConstants.largesShipCardsCount)
        XCTAssertEqual(deck.filter { $0.name == "Office" }.count, CardConstants.officeCardsCount)
        XCTAssertEqual(deck.filter { $0.name == "Crane" }.count, CardConstants.craneCardsCount)
        XCTAssertEqual(deck.filter { $0.name == "Warehouse" }.count, CardConstants.warehouseCardsCount)
    }

}
