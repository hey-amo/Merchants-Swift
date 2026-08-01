import Foundation

public enum GameMessageType: Int, Codable {
    case info, warning, success, error
}

public protocol GameMessageHandling: AnyObject {
    var messages: [GameMessage] { get }

    func add(_ message: GameMessage)
    func clear()
}

public final class GameMessageHandler: GameMessageHandling {
    public private(set) var messages: [GameMessage] = []

    public init() {}

    func getMessagesSortedByTimestamp() -> [GameMessage] {
        return messages.sorted { $0.timestamp < $1.timestamp }
    }

    public func add(_ message: GameMessage) {
        messages.append(message)
    }

    public func clear() {
        messages.removeAll()
    }
}

public struct GameMessage: Codable, Hashable {
    private let id = UUID()
    public let message: String
    public let timestamp: Date
    public let type: GameMessageType

    public init(message: String, timestamp: Date = Date(), messageType: GameMessageType = .info) {
        self.message = message
        self.timestamp = timestamp
        self.type = messageType
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
        case message
        case timestamp
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.type = try container.decode(GameMessageType.self, forKey: .type)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(type, forKey: .type)
    }
}