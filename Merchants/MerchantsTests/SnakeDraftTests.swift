import XCTest
@testable import Merchants

private struct DummyDraftPlayer: TurnOrderPlayer {
    let id: Int
}

final class SnakeDraftTests: XCTestCase {

    func testSnakeDraftOrderUsesSeparateTurnOrderManagers() {
        let players = [
            DummyDraftPlayer(id: 1),
            DummyDraftPlayer(id: 2),
            DummyDraftPlayer(id: 4),
            DummyDraftPlayer(id: 3)
        ]
        var normalTurnOrder = TurnOrderManager(players: players)
        var draftOrder: [DummyDraftPlayer] = []

        var firstDraftPass = TurnOrderManager(players: Array(players.reversed()))
        for _ in players.indices {
            draftOrder.append(firstDraftPass.currentPlayer)
            _ = firstDraftPass.advance()
        }

        var secondDraftPass = TurnOrderManager(players: players)
        for _ in players.indices {
            draftOrder.append(secondDraftPass.currentPlayer)
            _ = secondDraftPass.advance()
        }

        XCTAssertEqual(draftOrder.map(\.id), [3, 4, 2, 1, 1, 2, 4, 3])
        XCTAssertEqual(normalTurnOrder.currentPlayer, players[0])
        XCTAssertEqual(normalTurnOrder.advance(), players[1])
    }
}
    