//
//  CubeView.swift
//  Merchants
//
//  Created by Amarjit on 31/07/2026.
//

import SwiftUI

struct CubeView: View {
    let cubeColour: CubeColour
    let size: CGFloat

    init(cubeColour: CubeColour, size: CGFloat = 85) {
        self.cubeColour = cubeColour
        self.size = size
    }

    var body: some View {
        Image(cubeColour.resourceImageName())
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

#Preview {
    CubeView(cubeColour: .blue)
}
