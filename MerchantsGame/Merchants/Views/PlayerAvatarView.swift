//
//  PlayerAvatarView.swift
//  Merchants
//
//  Created by Amarjit on 31/10/2025.
//

import SwiftUI

/*
 Player avatars:
 - player-blue
 - player-yellow
 - player-red
 - player-purple
 - player-green
 */

struct PlayerAvatarView: View {
    var body: some View {
        Image("player-blue")
            .resizable()
            .frame(minWidth: 150, minHeight: 150, alignment: .center)
    }
}

#Preview {
    PlayerAvatarView()
}
