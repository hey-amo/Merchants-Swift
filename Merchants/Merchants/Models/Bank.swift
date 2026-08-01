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

class Bank {
	private var _balance: Int 
    public var balance: Int { return _balance }

	init(_ balance: Int = 0) {
		self._balance = balance
	}

	func perform(_ t: Transaction) {
		switch t {
        case .credit(let amount): credit(amount)
        case .debit(let amount): debit(amount)
		}
	}
}

extension Bank {
    private func credit(_ amount: Int = 0) {
        guard canCredit(amount) else { return }
        self._balance += amount
    }
    private func debit(_ amount: Int = 0) {
        guard canDebit(amount) else { return }
        self._balance -= amount
    }
}

extension Bank {
	private func canCredit(_ amount: Int = 0) -> Bool {
		guard amount > 0 else { return false}
		return true
	}
	private func canDebit(_ amount: Int = 0) -> Bool {
        guard (amount > 0) else { return false }
		guard (balance >= amount) else { return false }
		return true
	}
}
