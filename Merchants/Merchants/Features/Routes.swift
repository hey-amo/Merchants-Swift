import Observation
import Foundation

enum Route: Hashable {
    case playerSelection
    case game(GameSession)
    case pause(GameSession)
    case winner(GameSession)
}

final class GameSession: Hashable {
    let id: UUID
    let players: [Player]

    init(players: [Player], id: UUID = UUID()) {
        self.players = players
        self.id = id
    }

    static func == (lhs: GameSession, rhs: GameSession) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Observable
@MainActor
final class NavigationHandler {
    var path: [Route] = []

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
        path.removeAll()
    }
}
