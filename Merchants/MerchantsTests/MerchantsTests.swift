//
//  MerchantsTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 29/06/2026.
//

import XCTest

final class MerchantsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewGameCreatesExpectedGoodsCardsAndCubes() throws {
        let game = MerchantsGame(drawPile: [], cubePile: [], players: [])

        game.newGame(players: [Player(playerId: 1, coins: 0)])

        XCTAssertEqual(game.drawPile.count, 60)
        XCTAssertEqual(game.cubePile.count, 30)

        let cardCounts = Dictionary(grouping: game.drawPile, by: { $0 })
            .mapValues { $0.count }
        let cubeCounts = Dictionary(grouping: game.cubePile, by: { $0 })
            .mapValues { $0.count }

        for color in CubeColour.allCases {
            XCTAssertEqual(cardCounts[color], 10)
            XCTAssertEqual(cubeCounts[color], 5)
        }
    }

}
