//
//  ContentView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Image("ship")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .padding(.bottom, 20)
            
            Text("Merchants")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            VStack(spacing: 20) {
                Button(action: {
                    print("Play button pressed")
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
                
                Button(action: {
                    print("Continue button pressed")
                    // Hook for Continue action
                }) {
                    Text("Continue")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    print("Game Center button pressed")
                    // Hook for Game Center action
                }) {
                    Text("Game Center")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            Text("Copyright notice")
                .font(.footnote)
        }
        .background(Color(.systemTeal).opacity(0.15).ignoresSafeArea())
    }
}

#Preview {
    MainMenuView()
}
