import XCTest
@testable import Merchants

final class GameWinnerTests: XCTestCase {

    func testWinnerUsesSuppliedPlayersAndSortsByCoins() {
        let players = [
            Player(playerId: 1, coins: 10),
            Player(playerId: 2, coins: 14),
            Player(playerId: 3, coins: 3)
        ]
        let view = WinnerScreenView(players: players)

        XCTAssertEqual(view.sortedPlayers.map(\.playerId), [2, 1, 3])
        XCTAssertEqual(view.winners.map(\.playerId), [2])
    }

    func testWinnerIsATie() {
        let players = [
            Player(playerId: 1, coins: 10),
            Player(playerId: 2, coins: 14),
            Player(playerId: 3, coins: 14)
        ]
        let view = WinnerScreenView(players: players)

        XCTAssertEqual(Set(view.winners.map(\.playerId)), Set([2, 3]))
    }

    func testSamplePlayersCanBeEnabledAndDisabled() {
        let realPlayers = [Player(playerId: 6, coins: 30)]

        let sampleView = WinnerScreenView(players: realPlayers, useSamplePlayers: true)
        XCTAssertEqual(sampleView.sortedPlayers.map(\.playerId), [2, 1, 4, 3, 5])

        let realPlayersView = WinnerScreenView(players: realPlayers)
        XCTAssertEqual(realPlayersView.sortedPlayers.map(\.playerId), [6])
        XCTAssertEqual(realPlayersView.winners.map(\.playerId), [6])
    }
}
