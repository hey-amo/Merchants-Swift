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
            
            // Avatars row (centered)
            PlayerAvatarRowView()
            
            Spacer()
            
            /*
            // Main game board area (scrollable horizontally)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    // Place your game board content here
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(.systemTeal).opacity(0.15))
                        .frame(width: 600, height: 400)
                        .overlay(Text("Game Board Area").font(.title2).foregroundColor(.secondary))
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
             */
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear.ignoresSafeArea())
    }
}

#Preview {
    GameBoardView()
}
