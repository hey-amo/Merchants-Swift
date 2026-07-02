//
//  ContentView.swift
//  Merchants
//
//  Created by Amarjit on 29/06/2026.
//

import SwiftUI
//import SwiftData

struct MainMenuView: View {
    var body: some View {
        VStack {
            Text("Merchants").font(.largeTitle)
            Image("ship-nobg")
            Button("Play", action: {
                print("Pressed play")
            })
        }
    }
}

#Preview {
    MainMenuView()
}
