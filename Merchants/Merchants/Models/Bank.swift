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

class Bank: NSObject, NSCoding {
    private var _balance: Int
    public var balance: Int { _balance }

    init(_ balance: Int = 0) throws {
        guard balance >= 0 else {
            throw IntegerErrorType.negativeIntegerValue
        }
        self._balance = balance
        super.init()
    }

    required init?(coder: NSCoder) {
        let decodedBalance = coder.decodeInteger(forKey: "balance")
        guard decodedBalance >= 0 else {
            return nil
        }
        self._balance = decodedBalance
        super.init()
    }

    convenience init?(withCoder coder: NSCoder) {
        self.init(coder: coder)
    }

    func perform(_ t: Transaction) throws {
        switch t {
        case .credit(let amount): try credit(amount)
        case .debit(let amount): try debit(amount)
        }
    }

    func encode(with coder: NSCoder) {
        coder.encode(_balance, forKey: "balance")
    }

    func save(with coder: NSCoder) {
        encode(with: coder)
    }

    func saveWithCoder(_ coder: NSCoder) {
        save(with: coder)
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
