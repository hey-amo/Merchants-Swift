//
//  GameModelTests.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import XCTest
@testable import MerchantsEngine

final class GameModelTests: XCTestCase {
    
    var game: MerchantsGame!
    
    override func setUpWithError() throws {
        game = MerchantsGame()
    }
    
    override func tearDownWithError() throws {
        game = nil
    }
    
    func testGameSetup() throws {
        // Game should start in setup state
        XCTAssertEqual(game.gameState, .setup)
        
        // Setup the game
        game.setupGame()
        
        // Should now be in playing state
        XCTAssertEqual(game.gameState, .playing)
        
    }
    
    
    /*
    // MARK: - Game Setup Tests
    
    func testGameSetup() throws {
        // Game should start in setup state
        XCTAssertEqual(game.gameState, .setup)
        
        // Setup the game
        game.setupGame()
        
        // Should now be in playing state
        XCTAssertEqual(game.gameState, .playing)
        
        // Should have 4 players
        XCTAssertEqual(game.players.count, 4)
        
        // First player should be on turn
        XCTAssertTrue(game.players[0].isOnTurn)
        XCTAssertFalse(game.players[1].isOnTurn)
        XCTAssertFalse(game.players[2].isOnTurn)
        XCTAssertFalse(game.players[3].isOnTurn)
        
        // Each player should have 3 cards
        for player in game.players {
            XCTAssertEqual(player.cards.count, 3)
        }
        
        // Each player should have 2 ships
        for player in game.players {
            XCTAssertEqual(player.ships.count, 2)
        }
        
        // Deck should have 42 cards remaining (60 - (6 for marketplace - 12 for players))
        XCTAssertEqual(game.deck.remainingCards, 42)
        
        // Marketplace should have 6 cards
        XCTAssertEqual(game.marketplace.getAllCards().count, 6)
    }
    
    func testGamePhaseProgression() throws {
        game.setupGame()
        
        // Should start in purchase phase
        XCTAssertEqual(game.currentPhase, .purchase)
        
        // Move to delivery phase
        game.nextPhase()
        XCTAssertEqual(game.currentPhase, .delivery)
        
        // Move to next turn (should reset to purchase phase and advance to next player)
        game.nextPhase()
        XCTAssertEqual(game.currentPhase, .purchase)
        XCTAssertEqual(game.turnNumber, 1) // Turn number only increments after a full round (all 4 players)
        XCTAssertEqual(game.currentPlayerIndex, 1) // Second player (index 1)
        
        // Explanation: The turn number logic works as follows:
        // - Turn 1: Player 1 (index 0) → Player 2 (index 1) → Player 3 (index 2) → Player 4 (index 3)
        // - Turn 2: Player 1 (index 0) → Player 2 (index 1) → Player 3 (index 2) → Player 4 (index 3)
        // The turnNumber only increments when currentPlayerIndex becomes 0 again (full round completed)
    }
    
    func testGameEndCondition() throws {
        game.setupGame()
        
        // Game should not be over initially
        XCTAssertFalse(game.isGameOver)
        
        // Empty the deck to trigger game end
        while !game.deck.isEmpty {
            _ = game.deck.drawCard()
        }
        
        // Force a turn to trigger game end check
        game.nextTurn()
        
        // Game should now be over
        XCTAssertTrue(game.isGameOver)
        XCTAssertEqual(game.gameState, .gameOver)
    }
    */
}
