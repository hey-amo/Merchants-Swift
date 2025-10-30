//
//  Avatar.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//
import Foundation
import UIKit
import SwiftUI

public enum Avatar: String, CaseIterable {
    case playerBlue = "player-blue"
    case playerRed = "player-red"
    case playerGreen = "player-green"
    case playerYellow = "player-yellow"
    
    // Computed property to get the UIImage
    public var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    // For SwiftUI
    public var imageName: String {
        return self.rawValue
    }
    
    public var colour: String {
        switch self {
        case .playerRed: return "Red"
        case .playerBlue: return "Blue"
        case .playerYellow: return "Yellow"
        case .playerGreen: return "Green"
        }
    }
}