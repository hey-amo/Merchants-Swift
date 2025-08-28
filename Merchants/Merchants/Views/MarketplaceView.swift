//
//  MarketplaceView.swift
//  Merchants
//
//  Created by Amarjit on 28/08/2025.
//

import SwiftUI
import MerchantsEngine

// 3x2 marketplace grid. Can render in skeleton state or filled with colored cards.
struct MarketplaceView: View {
    enum StateMode { case skeleton, filled }
    var mode: StateMode = .filled

    private let gridColumns = [GridItem(.fixed(84)), GridItem(.fixed(84)), GridItem(.fixed(84))]
    private let cardSize = CGSize(width: 72, height: 104)

    // Map GoodsColour to system Color for now
    private func color(for goods: GoodsColour) -> Color {
        switch goods {
        case .white: return Color(.systemGray5)
        case .blue: return .blue
        case .red: return .red
        case .green: return .green
        case .yellow: return .yellow
        case .brown: return .brown
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Marketplace")
                .font(.title3)
                .bold()

            LazyVGrid(columns: gridColumns, alignment: .center, spacing: 12) {
                ForEach(0..<6) { index in
                    switch mode {
                    case .skeleton:
                        GenericCardView(size: cardSize, cornerRadius: 12, fillColor: nil)
                    case .filled:
                        let all = GoodsColour.allCases
                        let colorIndex = index % all.count
                        GenericCardView(size: cardSize, cornerRadius: 12, fillColor: color(for: all[colorIndex]).opacity(0.85))
                    }
                }
            }
            .padding(8)
        }
    }
}

#Preview("Skeleton") {
    MarketplaceView(mode: .skeleton)
}

#Preview("Filled") {
    MarketplaceView(mode: .filled)
}
