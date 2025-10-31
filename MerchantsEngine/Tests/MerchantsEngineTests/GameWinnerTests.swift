//
//  GameWinnerTests.swift
//  MerchantsEngine
//
//  Created by Amarjit on 31/10/2025.
//

import XCTest

@testable import MerchantsEngine

final class GameWinnerTests: XCTestCase {

    var game: MerchantsGame?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.game = MerchantsGame()
        
        guard let game = self.game else {
            throw NSError(domain: "Game object is invalid", code: 0, userInfo: nil)
        }
                
        game.setupGame()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.game = nil
    }

    
    func testPlayerRankings() throws {
        guard let game = self.game else {
            throw NSError(domain: "Game object is invalid", code: 0, userInfo: nil)
        }
                
        game.players[0].coins = 15
        game.players[1].coins = 25
        game.players[2].coins = 10
        game.players[3].coins = 30
        
        let rankings = game.getPlayerRankings()
        
        // Should be sorted by coins descending
        XCTAssertEqual(rankings[0].coins, 30) // Player 4
        XCTAssertEqual(rankings[1].coins, 25) // Player 2
        XCTAssertEqual(rankings[2].coins, 15) // Player 1
        XCTAssertEqual(rankings[3].coins, 10) // Player 3
    }
    
    func testGameWinner() throws {
        guard let game = self.game else {
            throw NSError(domain: "Game object is invalid", code: 0, userInfo: nil)
        }
        
        // Expect the winner to be player [3] as they have the most coins
        
    }

}
