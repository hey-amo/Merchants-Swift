import Foundation

public enum GameStateError: Error {
    case invalidTransition(from: GameState, to: GameState)
    case invalidGameState
    case playerNotFound
    case unknownError
}

extension GameStateError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidTransition(let from, let to):
            return NSLocalizedString("Invalid transition from \(from.description) to \(to.description).", comment: "Invalid Transition Error")
        case .invalidGameState:
            return NSLocalizedString("The game is in an invalid state.", comment: "Invalid Game State Error")
        case .playerNotFound:
            return NSLocalizedString("The player was not found.", comment: "Player Not Found Error")
        case .unknownError:
            return NSLocalizedString("An unknown error has occurred.", comment: "Unknown Error")
        }
    }
}

public enum IntegerError: Error {
    case negativeValue
    case notEnoughFunds(required: Int, available: Int)
}

extension IntegerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .negativeValue:
            return NSLocalizedString("Value cannot be negative.", comment: "Negative Value Error")
        case .notEnoughFunds(let required, let available):
            return NSLocalizedString("Not enough funds. Required: \(required), Available: \(available).", comment: "Not Enough Funds Error")
        }
    }
}