//
//  ShipCardView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI
import MerchantsEngine

struct ShipCardView: View {
    var cubeColor: GoodsColour? = nil
    
    // Map GoodsColour to system colors
    func systemColor(for colour: GoodsColour) -> Color {
        switch colour {
        case .white: return .white
        case .blue: return .blue
        case .red: return .red
        case .green: return .green
        case .yellow: return .yellow
        case .brown: return .brown
        }
    }
    
    var body: some View {
        ZStack {
            CardBGView()
            
            VStack(spacing: 16) {
               Image("ship-nobg")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 60, height: 60)
                   .padding(.top, 35)
               
                Spacer(minLength: 30)
    
               ZStack {
                   if let cubeColor = cubeColor {
                       // draw cube
                       RoundedRectangle(cornerRadius: 8)
                           .fill(systemColor(for: cubeColor))
                           .frame(width: 32, height: 32)
                           .overlay(
                               RoundedRectangle(cornerRadius: 8)
                                   .stroke(Color.black.opacity(0.2), lineWidth: 1)
                           )
                           .shadow(radius: 2)
                   }
                   else {
                       // dotted outline empty box
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(Color(.systemGray4), style: StrokeStyle(lineWidth: 2, dash: [4]))
                           .frame(width: 36, height: 36)
                           .background(Color.clear)
                   }
                   
               }
               .padding(.bottom, 24)
               
               Spacer()
           }
           .frame(width: 120, height: 180)
        }
    }
}

#Preview("Empty Ship") {
    ShipCardView()
}

#Preview("Ship with Single Blue Cube") {
    ShipCardView(cubeColor: .blue)
}
