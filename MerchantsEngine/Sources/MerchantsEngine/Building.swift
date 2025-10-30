//
//  Buildings.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

public enum SpecialBuildingTypes: CaseIterable {
    case ship, office, warehouse, forklift, crane
    
    public var cost: Int {
        switch self {
        case .ship: return 10
        case .office: return 8
        case .warehouse: return 15
        case .forklift: return 15
        case .crane: return 12
        }
    }
    
    public var description: String {
        switch self {
        case .ship: return "Ship"
        case .office: return "Office"
        case .warehouse: return "Warehouse"
        case .forklift: return "Forklift"
        case .crane: return "Crane"
        }
    }
}