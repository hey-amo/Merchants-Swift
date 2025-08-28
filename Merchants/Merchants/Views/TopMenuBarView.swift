//
//  TopMenuBarView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI

struct TopMenuBarView: View {
    var buildNumber: String {
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
        }
    
    var body: some View {
    
        // Top bar: Hamburger menu, avatars, settings button
        HStack(alignment: .center) {
            // Hamburger menu
            
            Text("Merchants, Build: \(buildNumber)")
                .font(.caption)
            
            Spacer(minLength: 10)
            
            // Settings gear button
            Button(action: {
                print("Settings gear button pressed")
            }) {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.gray)
                    .padding(.trailing, 4)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Notification bell button
            Button(action: {
                print("Notification button pressed")
            }) {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.gray)
                    .padding(.trailing, 4)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 25)
        .padding(.top, 8)
        .frame(maxWidth: .infinity)
        .background(Color.clear)
        .zIndex(1)
        
    }

}

#Preview {
    TopMenuBarView()
}
