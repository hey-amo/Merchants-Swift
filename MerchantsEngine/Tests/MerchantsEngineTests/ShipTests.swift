//
//  ShipTests.swift
//  MerchantsEngine
//
//  Created by Amarjit on 31/10/2025.
//

import XCTest

@testable import MerchantsEngine

final class ShipTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    // MARK: - Ship Tests
    
    func testShipCreation() throws {
        let ship = Ship()
        
        XCTAssertTrue(ship.isEmpty)
        XCTAssertFalse(ship.isLoaded)
        XCTAssertNil(ship.goodsCube)
    }
    
    func testShipLoading() throws {
        var ship = Ship()
        let cube = GoodsCube(color: .red)
        
        // Test loading
        ship.goodsCube = cube
        
        XCTAssertFalse(ship.isEmpty)
        XCTAssertTrue(ship.isLoaded)
        XCTAssertEqual(ship.goodsCube?.color, .red)
    }

}
