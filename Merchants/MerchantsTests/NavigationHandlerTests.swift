import XCTest
@testable import Merchants

@MainActor
final class NavigationHandlerTests: XCTestCase {
    func testPushAndPopRoutes() {
        let navigation = NavigationHandler()
        let session = GameSession(players: [])

        navigation.push(.playerSelection)
        navigation.push(.game(session))

        XCTAssertEqual(navigation.path, [.playerSelection, .game(session)])

        navigation.pop()

        XCTAssertEqual(navigation.path, [.playerSelection])
    }

    func testPopToRootClearsRoutesAndReleasesGameSession() {
        let navigation = NavigationHandler()
        var session: GameSession? = GameSession(players: [])
        weak var weakSession = session

        if let session {
            navigation.push(.game(session))
            navigation.push(.pause(session))
        }
        session = nil

        XCTAssertNotNil(weakSession)

        navigation.popToRoot()

        XCTAssertTrue(navigation.path.isEmpty)
        XCTAssertNil(weakSession)
    }
}
