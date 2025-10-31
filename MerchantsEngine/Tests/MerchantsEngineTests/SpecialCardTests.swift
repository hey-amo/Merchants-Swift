//
//  SpecialCardTests.swift
//  MerchantsEngine
//
//  Created by Amarjit on 31/10/2025.
//

import XCTest

@testable import MerchantsEngine

final class SpecialCardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
}
