import Foundation

enum GameMessageType: Int, Codable {
    case info, warning, success, error
}

protocol GameMessageHandling: AnyObject {
    var messages: [GameMessage] { get }

    func add(_ message: GameMessage)
    func clear()
}

final class GameMessageHandler: GameMessageHandling {
    public private(set) var messages: [GameMessage] = []

    public init() {}

    func getMessagesSortedByTimestamp() -> [GameMessage] {
        return messages.sorted { $0.timestamp < $1.timestamp }
    }

    func add(_ message: GameMessage) {
        messages.append(message)
    }

    func clear() {
        messages.removeAll()
    }
}

struct GameMessage: Codable, Hashable {
    private let id = UUID()
    let message: String
    let timestamp: Date
    let type: GameMessageType

    init(message: String, timestamp: Date = Date(), type: GameMessageType = .info) {
        self.message = message
        self.timestamp = timestamp
        self.type = type
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case message
        case timestamp
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //self.id = try container.decode(String.self, forKey: .id)
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
