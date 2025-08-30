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
        
    var body: some View {
        ZStack {
            GenericCardView()
            
            VStack(spacing: 16) {
               Image("ship-nobg")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 60, height: 60)
                   .padding(.top, 35)
               
                Spacer(minLength: 30)
    
               ZStack {
                   if let cubeColor = cubeColor {
                       Image(GoodsColour.crateImageName(for:cubeColor))
                           .resizable()
                           .scaledToFit()
                           .frame(width: 32, height: 32)
                           .overlay(
                               Rectangle()
                                   .stroke(Color.black, lineWidth: 1)
                           )
                   }
                   else {
                       // dotted outline empty box
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(Color(.gray), style: StrokeStyle(lineWidth: 2, dash: [4]))
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
