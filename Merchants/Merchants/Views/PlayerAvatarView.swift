//
//  PlayerAvatarView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI
import MerchantsEngine

struct PlayerAvatarView: View {
    let avatar: Avatar
    var size: CGFloat = 48
    
    var body: some View {
        Image(avatar.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color(.systemGray4), lineWidth: 0)
            )
    }
}

#Preview("Blue") {
    PlayerAvatarView(avatar: .playerBlue)
}

#Preview("Red") {
    PlayerAvatarView(avatar: .playerRed)
}

#Preview("Green") {
    PlayerAvatarView(avatar: .playerGreen)
}

#Preview("Yellow") {
    PlayerAvatarView(avatar: .playerYellow)
}
