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
	public var hand: [CubeColour] {
		get {
			return _self.hand
		}
	}

	// add cubes
	func add(cubes: [CubeColour]) {
        // #TODO: Move to hand manager
        guard _handSize + cubes.count <= maxHandSize else {
            print("Cannot add card to hand: exceeds maximum hand size.")
            return
        }
        hand.append(contentsOf: cubes)
    }

    // remove a single cube 
	func removeCube(atIndex: Int = 0) {
		guard _hand.count > 0 else { return }
		// do safe handling of index, compare against hand.count
		// remove the cube, only when safely found the cube
	}

	func clearAll() {
		guard _hand.count > 0 else { return }
		_hand.removeAll()
	}
}