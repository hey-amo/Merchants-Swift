//
//  BankTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 01/08/2026.
//

import XCTest
@testable import Merchants

final class BankTests: XCTestCase {

    func testBalance() throws {
        let expected = 100
        let bank = try Bank(expected)
        XCTAssertEqual(bank.balance, 100)
    }

    func testCredit_PositiveValue() throws {
        let expected = 100
        let bank = try Bank(0)
        try bank.transaction(.credit(expected))
        XCTAssertEqual(bank.balance, 100)
    }

    func testCredit_NegativeValue_ShouldFail() throws {
        let bank = try Bank(100)
        XCTAssertThrowsError(try bank.transaction(.credit(-10))) { error in
            XCTAssertEqual(error as? IntegerErrorType, .negativeIntegerValue)
        }
    }

    func testDebit_ValueIsPositive() throws {
        let deposit = 100
        let subtract = 10
        let expectedBalance = deposit - subtract
        let bank = try Bank(deposit)
        XCTAssertEqual(bank.balance, deposit)
        try bank.transaction(.debit(subtract))
        XCTAssertEqual(bank.balance, expectedBalance)
    }

    func testDebit_NegativeValue_ShouldFail() throws {
        let bank = try Bank(100)
        XCTAssertThrowsError(try bank.transaction(.debit(-10))) { error in
            XCTAssertEqual(error as? IntegerErrorType, .negativeIntegerValue)
        }
    }

    func testDebit_NotEnoughFunds_ShouldFail() throws {
        let bank = try Bank(10)
        XCTAssertThrowsError(try bank.transaction(.debit(20))) { error in
            XCTAssertEqual(error as? IntegerErrorType, .notEnoughFunds)
        }
    }

    func testInit_NegativeBalance_ShouldThrow() {
        XCTAssertThrowsError(try Bank(-10)) { error in
            XCTAssertEqual(error as? IntegerErrorType, .negativeIntegerValue)
        }
    }

    func testInitWithCoder_RoundTripsBalance() throws {
        let bank = try Bank(42)

        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        archiver.encode(bank, forKey: NSKeyedArchiveRootObjectKey)
        archiver.finishEncoding()

        let data = archiver.encodedData

        let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
        unarchiver.requiresSecureCoding = true

        let decodedBank = unarchiver.decodeObject(
            of: Bank.self,
            forKey: NSKeyedArchiveRootObjectKey
        )
        unarchiver.finishDecoding()

        XCTAssertEqual(decodedBank?.balance, 42)
    }

    func testSaveWithCoder_EncodesBalance() throws {
        let bank = try Bank(27)
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        bank.save(with: archiver)
        archiver.finishEncoding()

        let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data as Data)
        let decodedBank = Bank(withCoder: unarchiver)
        XCTAssertEqual(decodedBank?.balance, 27)
    }
}
