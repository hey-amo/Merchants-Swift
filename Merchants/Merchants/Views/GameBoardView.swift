//
//  GameBoardView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI

struct GameBoardView: View {
    var body: some View {
        Button(action: {
            print("Settings")
            // Hook for Play action
        }) {
            Text("Settings")
                .font(.title2)
        }
    }
}

#Preview {
    GameBoardView()
}
