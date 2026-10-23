import SwiftUI

struct GameHeaderView: View {
    let players: [Player]
    let activePlayerID: Int?

    init(players: [Player], activePlayerID: Int? = nil) {
        self.players = players
        self.activePlayerID = activePlayerID
    }

    var body: some View {
        HStack(spacing: 12) {

            // List players in turn order
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(players, id: \.playerId) { player in
                        Button {
                            print("Selected player \(player.playerId)")
                        } label: {
                            VStack(spacing: 4) {
                                playerAvatar(for: player)
                                Text("Player \(player.playerId)")
                                    .font(.caption2)
                                    .lineLimit(1)
                            }
                            .frame(minWidth: 56)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Player \(player.playerId)")
                    }
                }
                .padding(.horizontal, 4)
            }

            // Notifications bell
            Button {
                print("Notifications tapped")
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: 20, weight: .medium))
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Notifications")

            // Menu button
            Button {
                print("Menu tapped")
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .medium))
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Menu")
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.regularMaterial)
    }

    @ViewBuilder
    private func playerAvatar(for player: Player) -> some View {
        if let avatar = AvatarResource(rawValue: player.avatar) {
            PlayerAvatarView(
                avatar: avatar,
                isSelected: player.playerId == activePlayerID
            )
        } else {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(player.playerId == activePlayerID ? .blue : .secondary)
                .overlay {
                    Circle()
                        .stroke(
                            player.playerId == activePlayerID ? Color.blue : Color.gray,
                            lineWidth: 2
                        )
                }
        }
    }
}

#Preview {
    GameHeaderView(
        players: [
            Player(playerId: 1, coins: 0, avatar: AvatarResource.avt1.rawValue),
            Player(playerId: 2, coins: 0, avatar: AvatarResource.avt2.rawValue),
            Player(playerId: 3, coins: 0, avatar: AvatarResource.avt3.rawValue),
            Player(playerId: 4, coins: 0, avatar: AvatarResource.avt4.rawValue)
        ],
        activePlayerID: 1
    )
}
