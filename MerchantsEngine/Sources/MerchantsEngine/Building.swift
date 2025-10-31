//
//  Buildings.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//

import Foundation

public enum SpecialBuildingTypes: CaseIterable {
    case ship, office, warehouse, crane, forklift
    
    public var cost: Int {
        switch self {
        case .ship: return 10
        case .office: return 8
        case .warehouse: return 15        
        case .forklift: return 11
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

    /// A player can only have:
    /// 4 ships
    /// 2 offices
    /// 2 warehouses
    /// 2 cranes
    /// 2 forklifts
    public static func maxCount(for buildingType: SpecialBuildingTypes) -> Int { 
        switch buildingType {
        case .ship: return 4
        case .office: return 2
        case .warehouse: return 2
        case .crane: return 2
        case .forklift: return 2
        }
    }
}

public struct SpecialBuildingCard: Identifiable, Equatable, Hashable {
    public let id = UUID()
    public let buildingType: SpecialBuildingTypes
    public let name: String
    public let action: String
    public let cost: Int
    
    public init(buildingType: SpecialBuildingTypes) {
        self.buildingType = buildingType
        self.name = buildingType.description
        self.action = buildingType.description
        self.cost = buildingType.cost
    }
}
