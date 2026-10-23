//
//  BankTests.swift
//  MerchantsTests
//
//  Created by Amarjit on 01/08/2026.
//

import XCTest
@testable import Merchants

private final class DummyPlayer: CoinUpdaterDelegate {
    var coins = 0

    func updateCoins(amount: Int) throws {
        coins += amount
    }
}

final class BankTests: XCTestCase {

    func testCredit_UpdatesDummyPlayerThroughProtocol() throws {
        let bank = try Bank()
        let player = DummyPlayer()

        try bank.apply(.credit(100), to: player)

        XCTAssertEqual(player.coins, 100)
    }

    func testDebit_UpdatesDummyPlayerThroughProtocol() throws {
        let bank = try Bank()
        let player = DummyPlayer()
        try bank.apply(.credit(100), to: player)

        try bank.apply(.debit(50), to: player)

        XCTAssertEqual(player.coins, 50)
    }

    func testBalance() throws {
        let expected = 100
        let bank = try Bank(expected)
        XCTAssertEqual(bank.balance, 100)
    }

    func testCredit_PositiveValue() throws {
        let expected = 100
        let bank = try Bank(0)
        try bank.apply(.credit(expected))
        XCTAssertEqual(bank.balance, 100)
    }

    func testCredit_NegativeValue_ShouldFail() throws {
        let bank = try Bank(100)
        XCTAssertThrowsError(try bank.apply(.credit(-10))) { error in
            XCTAssertEqual(error as? IntegerErrorType, .negativeIntegerValue)
        }
    }

    func testDebit_ValueIsPositive() throws {
        let deposit = 100
        let subtract = 10
        let expectedBalance = deposit - subtract
        let bank = try Bank(deposit)
        XCTAssertEqual(bank.balance, deposit)
        try bank.apply(.debit(subtract))
        XCTAssertEqual(bank.balance, expectedBalance)
    }

    func testDebit_NegativeValue_ShouldFail() throws {
        let bank = try Bank(100)
        XCTAssertThrowsError(try bank.apply(.debit(-10))) { error in
            XCTAssertEqual(error as? IntegerErrorType, .negativeIntegerValue)
        }
    }

    func testDebit_NotEnoughFunds_ShouldFail() throws {
        let bank = try Bank(10)
        XCTAssertThrowsError(try bank.apply(.debit(20))) { error in
            XCTAssertEqual(error as? IntegerErrorType, .notEnoughFunds)
        }
    }

    func testInit_NegativeBalance_ShouldThrow() {
        XCTAssertThrowsError(try Bank(-10)) { error in
            XCTAssertEqual(error as? IntegerErrorType, .negativeIntegerValue)
        }
    }

}
