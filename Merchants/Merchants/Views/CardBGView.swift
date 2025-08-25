//
//  CardBGView.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import SwiftUI

struct CardBGView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 18)
                      .fill(Color(.systemGray6))
                      .frame(width: 120, height: 180)
                      .shadow(radius: 4)
                      .overlay(
                          RoundedRectangle(cornerRadius: 18)
                              .stroke(Color(.systemGray3), lineWidth: 2)
                      )
    }
}

#Preview {
    CardBGView()
}
