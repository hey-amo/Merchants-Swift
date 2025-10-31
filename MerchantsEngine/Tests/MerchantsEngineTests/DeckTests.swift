//
//  DeckTests.swift
//  MerchantsEngine
//
//  Created by Amarjit on 31/10/2025.
//

import XCTest
@testable import MerchantsEngine

final class DeckTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    

}
