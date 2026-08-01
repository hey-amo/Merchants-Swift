import XCTest
@testable import Merchants

final class GameMessageTests: XCTestCase {

    func testAddGameMessage() throws {
        let gameMessageHandler = GameMessageHandler()
        let message1 = GameMessage(message: "Test message 1", timestamp: Date(), type: .info)
        let message2 = GameMessage(message: "Test message 2", timestamp: Date().addingTimeInterval(10), type: .warning)

        gameMessageHandler.add(message1)
        gameMessageHandler.add(message2)

        let messages = gameMessageHandler.getMessagesSortedByTimestamp()

        XCTAssertEqual(messages.count, 2)
        XCTAssertEqual(messages[0].message, "Test message 1")
        XCTAssertEqual(messages[1].message, "Test message 2")
    }

    func testClearGameMessages() throws {
        let gameMessageHandler = GameMessageHandler()
        let message1 = GameMessage(message: "Test message 1", timestamp: Date(), type: .info)
        let message2 = GameMessage(message: "Test message 2", timestamp: Date().addingTimeInterval(10), type: .warning)

        gameMessageHandler.add(message1)
        gameMessageHandler.add(message2)

        gameMessageHandler.clear()

        XCTAssertEqual(gameMessageHandler.messages.count, 0)
    }

}