//
//  GameBoardView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI
import MerchantsEngine

struct GameBoardView: View {
    var body: some View {
        VStack(spacing: 0) {
            TopMenuBarView()
                .padding(.bottom, 5)
            
            PlayerAvatarRowView()
            Spacer()
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear.ignoresSafeArea())
    }
}

#Preview {
    GameBoardView()
}
