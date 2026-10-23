// HandManager.swift

import Foundation

enum HandErrorType: Error {
    case handIsEmpty
    case reachedMaxHandSize
}

extension HandErrorType: CustomStringConvertible {
    var description: String {
        switch self {
        case .handIsEmpty: return NSLocalizedString("Hand is empty", comment: "handIsEmpty")
        case .reachedMaxHandSize: return NSLocalizedString("Cannot perform: exceeds maximum hand size", comment: "reachedMaxHandSize")
        }
    }
}

protocol HandUpdaterDelegate: AnyObject {
    func updateHand(with cubes: [GoodsCube]) throws
}

class HandManager {
	private var _hand: [GoodsCube] // hand of good cards
	private var _handSize: Int { 
		get {
			return _hand.count
		}
	}
	private var _maxHandSize: Int 
	public var hand: [GoodsCube] {
		get {
			return _hand
		}
	}

	init(hand: [GoodsCube], maxHandSize: Int = 0) {
		self._hand = hand
		self._maxHandSize = maxHandSize
	}

	// add cubes
	func add(cubes: [GoodsCube]) throws {
		guard _handSize + cubes.count <= _maxHandSize else {
            //print("Cannot add card to hand: exceeds maximum hand size.")
            //return
            throw HandErrorType.reachedMaxHandSize
        }
		_hand.append(contentsOf: cubes)
    }

    // remove a single cube 
	func removeCube(atIndex: Int = 0) {
        guard _hand.count > 0 else { return }
		guard _hand.indices.contains(atIndex) else { return }
		_hand.remove(at: atIndex)
	}

	func clearAll() {
		guard _hand.count > 0 else { return }
		_hand.removeAll()
	}
}
