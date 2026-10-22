// Bank.swift

import Foundation

enum IntegerErrorType: Error {
    case negativeIntegerValue
    case notEnoughFunds
}

extension IntegerErrorType: CustomStringConvertible {
    var description: String {
        switch self {
        case .negativeIntegerValue: return NSLocalizedString("Cannot be a negative value", comment: "negativeIntegerValue")
        case .notEnoughFunds: return NSLocalizedString("Not enough funds", comment: "notEnoughFunds")
        }
    }
}

enum Transaction {
    case credit(Int)
    case debit(Int)
}

protocol CoinUpdaterDelegate {
    func updateCoins(amount: Int)
}

class Bank {    
    private var _balance: Int
    public var balance: Int { _balance }

    init(_ balance: Int = 0) throws {
        guard balance >= 0 else {
            throw IntegerErrorType.negativeIntegerValue
        }
        self._balance = balance
    }

    func apply(_ t: Transaction) throws {
        switch t {
        case .credit(let amount): try credit(amount)
        case .debit(let amount): try debit(amount)
        }
    }
}

extension Bank {
    private func credit(_ amount: Int = 0) throws {
        guard amount > 0 else {
            throw IntegerErrorType.negativeIntegerValue
        }
        _balance += amount
    }

    private func debit(_ amount: Int = 0) throws {
        guard amount > 0 else {
            throw IntegerErrorType.negativeIntegerValue
        }
        guard balance >= amount else {
            throw IntegerErrorType.notEnoughFunds
        }
        _balance -= amount
    }
}
