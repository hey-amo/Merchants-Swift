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
    
    // MARK: - GoodsColour Tests
    
    func testGoodsColourCases() throws {
        // Test that we have exactly 6 colors
        XCTAssertEqual(GoodsColour.allCases.count, 6)
        
        // Test specific colors exist
        XCTAssertTrue(GoodsColour.allCases.contains(.white))
        XCTAssertTrue(GoodsColour.allCases.contains(.blue))
        XCTAssertTrue(GoodsColour.allCases.contains(.red))
        XCTAssertTrue(GoodsColour.allCases.contains(.green))
        XCTAssertTrue(GoodsColour.allCases.contains(.yellow))
        XCTAssertTrue(GoodsColour.allCases.contains(.brown))
        
        // Test descriptions
        XCTAssertEqual(GoodsColour.white.description, "White")
        XCTAssertEqual(GoodsColour.blue.description, "Blue")
        XCTAssertEqual(GoodsColour.red.description, "Red")
        XCTAssertEqual(GoodsColour.green.description, "Green")
        XCTAssertEqual(GoodsColour.yellow.description, "Yellow")
        XCTAssertEqual(GoodsColour.brown.description, "Brown")
    }
    
    // MARK: - GoodsCube Tests
    
    func testGoodsCubeCreation() throws {
        let whiteCube = GoodsCube(color: .white)
        let blueCube = GoodsCube(color: .blue)
        
        XCTAssertEqual(whiteCube.color, .white)
        XCTAssertEqual(blueCube.color, .blue)
        XCTAssertNotEqual(whiteCube.id, blueCube.id)
    }
    
    func testGoodsCubeEquality() throws {
        let cube1 = GoodsCube(color: .red)
        let cube2 = GoodsCube(color: .red)
        
        // Different IDs should make them unequal even with same color
        XCTAssertNotEqual(cube1, cube2)
    }
    
    // MARK: - GoodsCard Tests
    
    func testGoodsCardCreation() throws {
        let whiteCard = GoodsCard(color: .white)
        let blueCard = GoodsCard(color: .blue)
        
        XCTAssertEqual(whiteCard.color, .white)
        XCTAssertEqual(blueCard.color, .blue)
        XCTAssertNotEqual(whiteCard.id, blueCard.id)
    }
    
    func testGoodsCardEquality() throws {
        let card1 = GoodsCard(color: .green)
        let card2 = GoodsCard(color: .green)
        
        // Different IDs should make them unequal even with same color
        XCTAssertNotEqual(card1, card2)
    }
    
    // MARK: - Deck Tests
    
    func testDeckCreation() throws {
        let deck = Deck()
        
        // Should have exactly 60 cards (10 of each color)
        XCTAssertEqual(deck.remainingCards, 60)
        XCTAssertFalse(deck.isEmpty)
    }
    
    func testDeckShuffle() throws {
        let deck = Deck()
        let originalOrder = deck.remainingCards
        
        deck.shuffle()
        
        // Should still have same number of cards
        XCTAssertEqual(deck.remainingCards, originalOrder)
    }
    
    func testDeckDrawCard() throws {
        let deck = Deck()
        let initialCount = deck.remainingCards
        
        let card = deck.drawCard()
        
        XCTAssertNotNil(card)
        XCTAssertEqual(deck.remainingCards, initialCount - 1)
    }
    
    func testDeckDrawMultipleCards() throws {
        let deck = Deck()
        let initialCount = deck.remainingCards
        
        let cards = deck.drawCards(5)
        
        XCTAssertEqual(cards.count, 5)
        XCTAssertEqual(deck.remainingCards, initialCount - 5)
    }
    
    func testDeckEmpty() throws {
        let deck = Deck()
        
        // Draw all cards
        for _ in 0..<60 {
            _ = deck.drawCard()
        }
        
        XCTAssertTrue(deck.isEmpty)
        XCTAssertEqual(deck.remainingCards, 0)
        
        // Try to draw from empty deck
        let card = deck.drawCard()
        XCTAssertNil(card)
    }
    
    // MARK: - SpecialBuildingTypes Tests
    
    func testSpecialBuildingTypes() throws {
        // Test we have exactly 5 building types
        XCTAssertEqual(SpecialBuildingTypes.allCases.count, 5)
        
        // Test costs
        XCTAssertEqual(SpecialBuildingTypes.ship.cost, 10)
        XCTAssertEqual(SpecialBuildingTypes.office.cost, 8)
        XCTAssertEqual(SpecialBuildingTypes.warehouse.cost, 15)
        XCTAssertEqual(SpecialBuildingTypes.forklift.cost, 15)
        XCTAssertEqual(SpecialBuildingTypes.crane.cost, 12)
        
        // Test descriptions
        XCTAssertEqual(SpecialBuildingTypes.ship.description, "Ship")
        XCTAssertEqual(SpecialBuildingTypes.office.description, "Office")
        XCTAssertEqual(SpecialBuildingTypes.warehouse.description, "Warehouse")
        XCTAssertEqual(SpecialBuildingTypes.forklift.description, "Forklift")
        XCTAssertEqual(SpecialBuildingTypes.crane.description, "Crane")
    }
    
    // MARK: - SpecialBuildingCard Tests
    
    func testSpecialBuildingCardCreation() throws {
        let shipCard = SpecialBuildingCard(buildingType: .ship)
        let officeCard = SpecialBuildingCard(buildingType: .office)
        
        XCTAssertEqual(shipCard.buildingType, .ship)
        XCTAssertEqual(shipCard.cost, 10)
        XCTAssertEqual(shipCard.name, "Ship")
        
        XCTAssertEqual(officeCard.buildingType, .office)
        XCTAssertEqual(officeCard.cost, 8)
        XCTAssertEqual(officeCard.name, "Office")
    }
    
    // MARK: - Ship Tests
    
    func testShipCreation() throws {
        let ship = Ship()
        
        XCTAssertTrue(ship.isEmpty)
        XCTAssertFalse(ship.isLoaded)
        XCTAssertNil(ship.goodsCube)
    }
    
    func testShipLoading() throws {
        let ship = Ship()
        let cube = GoodsCube(color: .red)
        
        // Test loading
        ship.goodsCube = cube
        
        XCTAssertFalse(ship.isEmpty)
        XCTAssertTrue(ship.isLoaded)
        XCTAssertEqual(ship.goodsCube?.color, .red)
    }
    
    // MARK: - Player Tests
    
    func testPlayerCreation() throws {
        let player = Player()
        
        XCTAssertEqual(player.coins, 0)
        XCTAssertTrue(player.cards.isEmpty)
        XCTAssertTrue(player.specialBuildings.isEmpty)
        XCTAssertTrue(player.ships.isEmpty)
        XCTAssertFalse(player.isOnTurn)
    }
    
    func testPlayerAddCard() throws {
        let player = Player()
        let card = GoodsCard(color: .blue)
        
        player.addCard(card)
        
        XCTAssertEqual(player.cards.count, 1)
        XCTAssertEqual(player.cards.first?.color, .blue)
    }
    
    func testPlayerRemoveCard() throws {
        let player = Player()
        let card = GoodsCard(color: .green)
        
        player.addCard(card)
        XCTAssertEqual(player.cards.count, 1)
        
        let removed = player.removeCard(card)
        XCTAssertTrue(removed)
        XCTAssertTrue(player.cards.isEmpty)
    }
    
    func testPlayerHandSize() throws {
        let player = Player()
        
        // Base hand size should be 6
        XCTAssertEqual(player.handSize, 6)
        
        // Add warehouse to increase hand size
        let warehouse = SpecialBuildingCard(buildingType: .warehouse)
        player.addSpecialBuilding(warehouse)
        
        XCTAssertEqual(player.handSize, 8) // 6 + 2
    }
    
    func testPlayerMaxShips() throws {
        let player = Player()
        
        // Base ships should be 2
        XCTAssertEqual(player.maxShips, 2)
        
        // Add ship to increase max ships
        let shipCard = SpecialBuildingCard(buildingType: .ship)
        player.addSpecialBuilding(shipCard)
        
        XCTAssertEqual(player.maxShips, 3) // 2 + 1
    }
    
    // MARK: - Bank Tests
    
    func testBankCanAfford() throws {
        let bank = Bank()
        let player = Player()
        
        player.coins = 10
        
        XCTAssertTrue(bank.canAfford(player: player, amount: 5))
        XCTAssertTrue(bank.canAfford(player: player, amount: 10))
        XCTAssertFalse(bank.canAfford(player: player, amount: 15))
    }
    
    func testBankDebit() throws {
        let bank = Bank()
        let player = Player()
        
        player.coins = 20
        
        let success = bank.debit(player: player, amount: 8)
        
        XCTAssertTrue(success)
        XCTAssertEqual(player.coins, 12)
    }
    
    func testBankDebitInsufficientFunds() throws {
        let bank = Bank()
        let player = Player()
        
        player.coins = 5
        
        let success = bank.debit(player: player, amount: 10)
        
        XCTAssertFalse(success)
        XCTAssertEqual(player.coins, 5) // Should remain unchanged
    }
    
    func testBankCredit() throws {
        let bank = Bank()
        let player = Player()
        
        player.coins = 15
        
        bank.credit(player: player, amount: 7)
        
        XCTAssertEqual(player.coins, 22)
    }
    
    // MARK: - Marketplace Tests
    
    func testMarketplaceSetup() throws {
        let marketplace = Marketplace()
        let deck = Deck()
        
        marketplace.setupMarketplace(from: deck)
        
        // Should have 6 cards
        XCTAssertEqual(marketplace.getAllCards().count, 6)
        XCTAssertEqual(deck.remainingCards, 54) // 60 - 6
    }
    
    func testMarketplaceAddCards() throws {
        let marketplace = Marketplace()
        let cards = [
            GoodsCard(color: .red),
            GoodsCard(color: .blue),
            GoodsCard(color: .green)
        ]
        
        marketplace.addCards(cards)
        
        XCTAssertEqual(marketplace.getAllCards().count, 3)
    }
    
    func testMarketplaceGetCardsByColor() throws {
        let marketplace = Marketplace()
        let cards = [
            GoodsCard(color: .red),
            GoodsCard(color: .blue),
            GoodsCard(color: .red),
            GoodsCard(color: .green)
        ]
        
        marketplace.addCards(cards)
        
        let redCards = marketplace.getCards(of: .red)
        XCTAssertEqual(redCards.count, 2)
        
        let blueCards = marketplace.getCards(of: .blue)
        XCTAssertEqual(blueCards.count, 1)
        
        let greenCards = marketplace.getCards(of: .green)
        XCTAssertEqual(greenCards.count, 1)
    }
    
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
        
        // Deck should have 54 cards remaining (60 - 6 for marketplace - 12 for players)
        XCTAssertEqual(game.deck.remainingCards, 54)
        
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
        
        // Move to next turn (should reset to purchase phase)
        game.nextPhase()
        XCTAssertEqual(game.currentPhase, .purchase)
        XCTAssertEqual(game.turnNumber, 2)
        XCTAssertEqual(game.currentPlayerIndex, 1) // Second player
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
    
    func testPlayerRankings() throws {
        game.setupGame()
        
        // Give players different coin amounts
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
}
