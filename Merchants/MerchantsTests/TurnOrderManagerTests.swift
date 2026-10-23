import XCTest
@testable import Merchants

private struct DummyTurnOrderPlayer: TurnOrderPlayer {
    let id: Int
}

final class TurnOrderManagerTests: XCTestCase {

    private func makePlayers() -> [DummyTurnOrderPlayer] {
        [
            DummyTurnOrderPlayer(id: 1),
            DummyTurnOrderPlayer(id: 2),
            DummyTurnOrderPlayer(id: 3),
            DummyTurnOrderPlayer(id: 4)
        ]
    }

    func testAdvanceMovesToNextPlayer() {
        let players = makePlayers()
        var manager = TurnOrderManager(players: players)

        XCTAssertEqual(manager.currentPlayer, players[0])
        XCTAssertEqual(manager.advance(), players[1])
        XCTAssertEqual(manager.currentPlayer, players[1])
    }

    func testAdvanceLoopsBackToFirstPlayer() {
        let players = makePlayers()
        var manager = TurnOrderManager(players: players)

        _ = manager.advance()
        _ = manager.advance()
        XCTAssertEqual(manager.advance(), players[3])

        XCTAssertEqual(manager.advance(), players[0])
        XCTAssertEqual(manager.currentPlayer, players[0])
    }

    func testGameActivePlayerComesFromTurnOrderManager() {
        let players = (1...4).map { Player(playerId: $0, coins: 0) }
        let game = MerchantsGame(buildings: [], drawPile: [], cubePile: [], players: players)

        XCTAssertTrue(game.activePlayer === players[0])
        XCTAssertTrue(game.advanceTurn() === players[1])
        XCTAssertTrue(game.activePlayer === players[1])
    }

    func testGameWithoutPlayersHasNoActivePlayer() {
        let game = MerchantsGame(buildings: [], drawPile: [], cubePile: [], players: [])

        XCTAssertNil(game.activePlayer)
        XCTAssertNil(game.advanceTurn())
    }
}
