//
//  GoodCardTests.swift
//  MerchantsEngine
//
//  Created by Amarjit on 31/10/2025.
//

import XCTest
@testable import MerchantsEngine

final class GoodCardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
}
