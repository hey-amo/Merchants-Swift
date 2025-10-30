//
//  Goods.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

// MARK: - Goods

public enum GoodsColour: Int, CaseIterable {
    case white = 0, blue = 1, red = 2, green = 3, yellow = 4, brown = 5
    
    public var description: String {
        switch self {
        case .white: return "White"
        case .blue: return "Blue"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .brown: return "Brown"
        }
    }
    
    // Map GoodsColour to an image
    public static func crateImageName(for colour: GoodsColour) -> String {
        switch colour {
        case .white: return "crate-white"
        case .blue: return "crate-blue"
        case .green: return "crate-green"
        case .yellow: return "crate-yellow"
        case .brown: return "crate-brown"
        case .red: return "crate-red"
        }
    }
    
    // Map GoodsColour to system colors
    public static func mapGoodToSystemColor(for colour: GoodsColour) -> Color {
        switch colour {
        case .white: return .white
        case .blue: return .blue
        case .red: return .red
        case .green: return .green
        case .yellow: return .yellow
        case .brown: return .brown
        }
    }
}


// MARK: Good cards

public struct GoodsCard: Identifiable, Equatable, Hashable {
    public let id = UUID()
    public let color: GoodsColour
    
    public static func == (lhs: GoodsCard, rhs: GoodsCard) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public struct GoodsCube: Identifiable, Equatable, Hashable {
    public let id = UUID()
    public let color: GoodsColour
    
    public static func == (lhs: GoodsCube, rhs: GoodsCube) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
