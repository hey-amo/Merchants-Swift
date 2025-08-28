//
//  CardBGView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI

// A resizable, color-adaptable playing card shell used in many screens.
// - If fillColor is nil, the view renders a skeleton (outline only)
// - Otherwise, it renders a filled card with subtle shadow and border
struct GenericCardView: View {
    var size: CGSize = CGSize(width: 80, height: 120)
    var cornerRadius: CGFloat = 12
    var fillColor: Color? = nil

    var body: some View {
        let isSkeleton = (fillColor == nil)

        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(fillColor ?? Color.clear)
            .frame(width: size.width, height: size.height)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        isSkeleton ? Color(.systemGray4) : Color(.systemGray3),
                        style: StrokeStyle(
                            lineWidth: isSkeleton ? 2 : 1,
                            dash: isSkeleton ? [6] : []
                        )
                    )
            )
            .shadow(color: Color.black.opacity(isSkeleton ? 0.0 : 0.08), radius: 2, x: 0, y: 1)
    }
}

#Preview("Skeleton") {
    GenericCardView(size: CGSize(width: 80, height: 120), cornerRadius: 12, fillColor: nil)
}

#Preview("Filled (Blue)") {
    GenericCardView(size: CGSize(width: 80, height: 120), cornerRadius: 12, fillColor: .blue)
}

