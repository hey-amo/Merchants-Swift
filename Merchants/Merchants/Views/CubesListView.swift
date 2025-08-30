//
//  CubesListView.swift
//  Merchants
//
//  Created by Amarjit on 30/08/2025.
//

import SwiftUI
import MerchantsEngine

// A list of remaining available cubes/crates in the game

struct CubesListView: View {
    var body: some View {
        HStack(spacing: 10) {
            
            MiniCrateView(crateImageName: "crate-red", cubesRemaining: 5)
        }
    }
}

struct MiniCrateView: View {
    let crateImageName: String
    let cubesRemaining: Int
    var body: some View {
        VStack(spacing:3.0) {
            Image(crateImageName)
            Text("Cubes remaining: \(cubesRemaining)")
        }
    }
}

#Preview {
    CubesListView()
}
