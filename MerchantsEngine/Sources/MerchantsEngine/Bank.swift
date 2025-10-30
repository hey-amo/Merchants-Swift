//
//  Bank.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//
import Foundation

// MARK: - Bank Class

public protocol BankableProtocol {
    func updateBalance(by amount: Int)
}

public struct Bank {
    public var balance: Int

    public init(with balance: Int) {
        self.balance = balance
    }

    public mutating func credit(amount: Int) throws -> Bool {
        guard amount > 0 else {
            throw IntegerError.negativeValue
        }
        self.didCredit(amount: amount)
        print("Bank credited with \(amount). New balance: \(balance)")
        return true
    }


    public mutating func debit(amount: Int) throws -> Bool {
        guard balance >= amount else {
            print("Bank cannot debit \(amount). Insufficient balance: \(balance)")
            return false
        }
        let sum: Int = (balance -= amount)
        guard sum >= 0 else {
            throw IntegerError.negativeValue
        }
        didDebit(amount)
        print("Bank debited with \(amount). New balance: \(balance)")
        return true
    }

    // MARK: - Private Methods

    private mutating func didCredit(_ amount: Int = 0) {
        balance += amount
    }

    private mutating func didDebit(_ amount: Int = 0) {
        balance -= amount
    }

    private func canAfford(cost: Int) -> Bool {
        return ( balance >= cost )
    }
}
