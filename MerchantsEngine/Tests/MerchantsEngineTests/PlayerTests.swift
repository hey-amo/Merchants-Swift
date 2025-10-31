//
//  PlayerTests.swift
//  MerchantsEngine
//
//  Created by Amarjit on 31/10/2025.
//


import XCTest

@testable import MerchantsEngine

final class PlayerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        
        player.addGoodsCard(card)
        
        XCTAssertEqual(player.cards.count, 1)
        XCTAssertEqual(player.cards.first?.color, .blue)
    }

    func testPlayerRemoveCard() throws {
        let player = Player()
        let card = GoodsCard(color: .green)
        
        /*
        player.addGoodsCard(card)
        XCTAssertEqual(player.cards.count, 1)
        
        let removed = player.popGoodsCard(, card: T##GoodsCard)(card)
        XCTAssertTrue(removed)
        XCTAssertTrue(player.cards.isEmpty)*/
    }

    func testPlayerHandSize() throws {
        let player = Player()
        
        // Base hand size should be 6
        XCTAssertEqual(player.handSize, 6)
        
        // Add warehouse to increase hand size
        let warehouse = SpecialBuildingCard(buildingType: .warehouse)
        
        //player.addSpecialBuilding(warehouse)
        
        XCTAssertEqual(player.handSize, 8) // 6 + 2
    }

    func testPlayerMaxShips() throws {
        let player = Player()
        
        // Base ships should be 2
        XCTAssertEqual(player.maxShips, 2)
        
        // Add ship to increase max ships
        //let shipCard = SpecialBuildingCard(buildingType: .ship)
        //player.addSpecialBuilding(shipCard)
        //XCTAssertEqual(player.maxShips, 3) // 2 + 1
    }

    
}
