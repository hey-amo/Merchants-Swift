//
//  MarketplaceTests.swift
//  MerchantsEngine
//
//  Created by Amarjit on 31/10/2025.
//

import XCTest

@testable import MerchantsEngine

final class MarketplaceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
      
    
    
    // MARK: - Test Payouts

    func testPayoutsFor_ThreePlayers() throws {
      print ("Test payouts for 3 players")

      // Fill marketplace with cards
      let marketplace = Marketplace()
      let cards = [
          GoodsCard(color: .red),
          GoodsCard(color: .blue),
          GoodsCard(color: .red),
          GoodsCard(color: .green),
          GoodsCard(color: .white),
          GoodsCard(color: .white)
      ]

      // Next create 3 players
      
      // Next give each player 1 ship with 1 red cube
      
      // Mock a delivery of red cards to the marketplace
      
      // Expect payout for red cards
    }

    
      

}
