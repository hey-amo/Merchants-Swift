// HandManager.swift

import Foundation

protocol HandManagerUpdater: AnyObject {
    func updateHand(with cubes: [CubeColour])
}

// This shouldn't care about the player

class HandManager {
	private var _hand: [CubeColour] // hand of good cards
	private var _handSize: Int { 
		get {
			return _hand.count
		}
	}
	private var _maxHandSize: Int 
	public var hand: [CubeColour] {
		get {
			return _self.hand
		}
	}

	init(hand: [CubeColour], maxHandSize: Int = 0) {
		self._hand = hand
		self._maxHandSize = maxHandSize
	}

	// add cubes
	func add(cubes: [CubeColour]) {
        guard _handSize + cubes.count <= maxHandSize else {
            print("Cannot add card to hand: exceeds maximum hand size.")
            return
        }
        hand.append(contentsOf: cubes)
    }

    // remove a single cube 
	func removeCube(atIndex: Int = 0) {
		guard atIndex >= 0 else { return }
		guard _hand.count > 0 else { return }
		// do safe handling of index, compare against hand.count
		// remove the cube, only when safely found the cube
		// if it can't find the cube, fail
	}

	func clearAll() {
		guard _hand.count > 0 else { return }
		_hand.removeAll()
	}
}