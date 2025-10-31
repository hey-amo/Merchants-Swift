//
//  PlayerViewModel.swift
//  Merchants
//
//  Created by Amarjit on 31/10/2025.
//

import Foundation

struct PlayerViewModel: Identifiable, Hashable, Equatable {
    var id: UUID
    let name: String
    let avatar: String
    let coins: Int
}
