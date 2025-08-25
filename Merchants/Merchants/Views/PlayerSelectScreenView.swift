//
//  PlayerSelectScreenView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI
import Foundation
import MerchantsEngine

// Screen to select 2-4 players
// Uses avatars and switch AI on/off
struct PlayerSelectScreenView: View {
    var body: some View {        
        VStack {
            Text("Select players")
                .font(.headline)
            
            Button(action: {
                print("Pressed: Play")
                // Hook for Play action
            }) {
                Text("Play")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.85))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    PlayerSelectScreenView()
}
