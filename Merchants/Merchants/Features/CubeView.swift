//
//  CubeView.swift
//  Merchants
//
//  Created by Amarjit on 31/07/2026.
//

import SwiftUI

// Displays a single goods cube

struct CubeView: View {
    let cube: GoodsCube
    let size: CGFloat

    init(cube: GoodsCube, size: CGFloat = 85) {
        self.cube = cube
        self.size = size
    }

    var body: some View {
        Image(cube.resourceImageName())
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

#Preview {
    CubeView(cube: .indigo)
}
