//
//  BankTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 01/08/2026.
//

import XCTest
@testable import Merchants

final class BankTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBalance() throws {
        let expected = 100
        let bank = Bank(expected)
        XCTAssertEqual(bank.balance, 100)
    }
    
    func testCredit_PositiveValue() throws {
        let expected = 100
        let bank = Bank(0)
        bank.perform(.credit(expected))
        XCTAssertEqual(bank.balance, 100)
    }
    
    func testCredit_NegativeValue_ShouldFail() throws {
        
    }
    
    func testDebit_PositiveValue() throws {
        let deposit = 100
        let subtract = 10
        let expected = (deposit - subtract)
        let bank = Bank(deposit)
        XCTAssertEqual(bank.balance, deposit)
        bank.perform(.debit(expected))
        XCTAssertEqual(bank.balance, expected)
    }
    
    func testDebit_NegativeValue_ShouldFail() throws {
        
    }
    
    func testDebit_NotEnoughFunds_ShouldFail() throws {
        
    }

}
