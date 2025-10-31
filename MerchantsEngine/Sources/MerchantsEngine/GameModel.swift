//
//  GameModel.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//
import Foundation
import GameplayKit
import SwiftUI

// MARK: Game constants

// Game rules & constants
public enum GameRules {
    public enum Player {
        public static let minCount: Int = 2
        public static let maxCount: Int = 5
        
        public static func isValid(count: Int) -> Bool {
            (minCount...maxCount).contains(count)
        }
    }
    
    public enum Economy {
        public static let startingCoins: Int = 0
        public static let startingShips: Int = 2
        public static let startingHandSize: Int = 3
        public static let payoutPerCube: Int = 1
        public static let payoutDeliveryBonusPerOffice: Int = 2
    }
}

// MARK: Game State

public enum GameState: CaseIterable {
    case setup, idle, playing, gameOver
    
    public var description: String {
        switch self {
        case .setup: return "Setup"
        case .idle: return "Idle"
        case .playing: return "Playing"
        case .gameOver: return "Game Over"
        }
    }
}

// MARK: Player Actions enum

public enum PlayerAction: CaseIterable {
    case exchangeCubes, buySpecialCard, pass, makeDelivery, drawCards
    
    public var description: String {
        switch self {
        case .exchangeCubes: return "Exchange Cubes"
        case .buySpecialCard: return "Buy 1 Special Card"
        case .pass: return "Pass"
        case .makeDelivery: return "Make a Delivery"
        case .drawCards: return "Draw Cards"
        }
    }
}
public enum GamePhase: Int, CaseIterable {
    case purchase, delivery
}

// MARK: - Goods

public enum GoodsColour: Int, CaseIterable {
    case white, blue, red, green, yellow, brown
    
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

// MARK: Ship
public struct Ship: Identifiable, Equatable, Hashable {
    public let id = UUID()
    public var goodsCube: GoodsCube?
    
    public var isEmpty: Bool {
        return goodsCube == nil
    }
    
    public var isLoaded: Bool {
        return goodsCube != nil
    }

    public mutating func setGoodsCube(_ cube: GoodsCube?) -> Ship {
        var updatedShip = self
        updatedShip.goodsCube = cube
        return updatedShip
    }
}

// MARK: - Player Class

/// A player in the Merchants game
/// A player has:
/// - coins
/// - goods cards (hand)
/// - a collection of special buildings
/// - a collection of ships 
/// - an avatar
/// - isOnTurn flag
/// - isAI flag
/// - hand size (Int) - base 6 + 2 per warehouse

public class Player: Identifiable, Hashable, Equatable {
    public let id: UUID = UUID()
    public var coins: Int = 0
    public var cards: [GoodsCard] = []
    public var specialBuildings: [SpecialBuildingCard] = []
    public var ships: [Ship] = []
    public var isOnTurn: Bool = false
    public var avatar: Avatar?
    public var isAI: Bool = false 

    public var hand: [GoodsCard] {
        return self.cards
    }

    /// Warehouse benefit: Hand size: base: 6 + 2 per warehouse
    public var handSize: Int {
        let baseHandSize = 6
        let warehouseBonus = specialBuildings.filter { $0.buildingType == .warehouse }.count * 2
        return baseHandSize + warehouseBonus
    }

    /// Max ships: 2
    public var maxShips: Int {
        let baseShips = 4
        //let shipBonus = specialBuildings.filter { $0.buildingType == .ship }.count
        return baseShips //+ shipBonus
    }

    /// Get all good cubes the player has
    public func getGoodsCubes() -> [GoodsCube] {
        return ships.compactMap { $0.goodsCube }
    }    

    public var hasCrane: Bool {
        return specialBuildings.contains { $0.buildingType == .crane }
    }
    
    public var deliveryBonus: Int {
        return specialBuildings.filter { $0.buildingType == .office }.count * 2
    }
    
    public var drawCardBonus: Int {
        return specialBuildings.filter { $0.buildingType == .forklift }.count
    }

    public func addGoodsCard(_ card: GoodsCard) {
        // Check hand limit
        let handLimit: Int = handSize
        guard cards.count < handLimit else {
            print("Player \(id) cannot add more cards, hand limit reached")
            return
        }

        cards.append(card)
    }

    // MARK: Equatable & Hashable
 
    public static func == (left: Player, right: Player) -> Bool {
        return left.id == right.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Ship handler
public class ShipHandler {
    public func addShip(to player: Player) {
        // this needs to be regulate by the special building handler
        let newShip = Ship()
        player.ships.append(newShip)
    }
    
    public func loadShip(_ ship: Ship, with cube: GoodsCube, for player: Player) -> Bool {
        guard let shipIndex = player.ships.firstIndex(of: ship) else { return false }
        guard player.ships[shipIndex].isEmpty else { return false }
        
        player.ships[shipIndex].goodsCube = cube
        return true
    }
    
    public func unloadShip(_ ship: Ship, for player: Player) -> GoodsCube? {
        guard let shipIndex = player.ships.firstIndex(of: ship) else { return nil }
        let cube = player.ships[shipIndex].goodsCube
        player.ships[shipIndex].goodsCube = nil
        return cube
    }
}

// MARK: Special buildings handler

public class SpecialBuildingHandler {
    
    public func addSpecialBuilding(to player: Player, building: SpecialBuildingCard) {
        // count how many special buildings of this type the player has
        let existingCount = player.specialBuildings.filter { $0.buildingType == building.buildingType }.count
        // get max count allowed for this building type
        let maxCount = SpecialBuildingTypes.maxCount(for: building.buildingType)
        
        guard existingCount < maxCount else {
            print("Player \(player.id) cannot add more \(building.buildingType.description)s")
            return
        }

        player.specialBuildings.append(building)
    }
}

// MARK: Goods card handler

public class GoodsCardHandler {
    public func addGoodsCard(to player: Player, card: GoodsCard) {
        player.cards.append(card)
    }

    public func popGoodsCard(from player: Player, card: GoodsCard) -> Bool {
        if let index = player.cards.firstIndex(of: card) {
            player.cards.remove(at: index)
            return true
        }
        return false
    }

    public func popGoodsCardAtIndex(from player: Player, index: Int) -> GoodsCard? {
        guard index >= 0 && index < player.cards.count else {
            return nil
        }
        return player.cards.remove(at: index)
    }   

    public func popGoodsCardMatchingID(from player: Player, cardID: UUID) -> GoodsCard? {
        if let index = player.cards.firstIndex(where: { $0.id == cardID }) {
            return player.cards.remove(at: index)
        }
        return nil
    }
}


// MARK: - Deck class

public class Deck {
    private var cards: [GoodsCard] = []
    
    public init() {
        createDeck()
    }

    deinit {
        print("Deck deinitialized")
        self.cards.removeAll()
    }
    
    private func createDeck() {
        cards.removeAll()
        
        // Create 10 cards of each color
        for color in GoodsColour.allCases {
            for _ in 0..<10 {
                cards.append(GoodsCard(color: color))
            }
        }
        
        print("Created deck with: \(cards.count) cards")
    }
    
    public func shuffle() {
        cards.shuffle()
        print("Deck shuffled")
    }
    
    public func drawCard() -> GoodsCard? {
        guard !cards.isEmpty else { return nil }
        let card = cards.removeFirst()
        print("Drew \(card.color.description) card. Remaining: \(cards.count)")
        return card
    }
    
    public func drawCards(_ count: Int) -> [GoodsCard] {
        var drawnCards: [GoodsCard] = []
        for _ in 0..<count {
            if let card = drawCard() {
                drawnCards.append(card)
            } else {
                break
            }
        }
        return drawnCards
    }
    
    public var isEmpty: Bool {
        return cards.isEmpty
    }
    
    public var remainingCards: Int {
        return cards.count
    }
}


// MARK: - Marketplace Class

public class Marketplace {
    private var marketCards: [GoodsCard] = []
    
    public init() {}
    
    public func setupMarketplace(from deck: Deck) {
        marketCards.removeAll()
        
        // Draw 6 cards to create a fixed 2x3 marketplace of cards
        let drawnCards = deck.drawCards(6)
        marketCards = drawnCards
        
        print("Marketplace setup with \(marketCards.count) cards")
        for card in marketCards {
            print("Marketplace card: \(card.color.description)")
        }
    }

    /// # Adding cards to the marktplace:
    /// When a player add's cards to the marketplace, we only replace 
    /// specific cards in the marketplace at specific indexes
    /// The marketplace is fixed to 6 cards
    public func addCards(_ cards: [GoodsCard], at indexes: [Int]) {
        guard cards.count == indexes.count else {
            print("Error: Number of cards and indexes must match")
            return
        }
        
        for (i, index) in indexes.enumerated() {
            guard index >= 0 && index < marketCards.count else {
                print("Error: Index \(index) out of bounds")
                continue
            }
            marketCards[index] = cards[i]
            print("Replaced marketplace card at index \(index) with \(cards[i].color.description) card")
        }
    }

    public func getCards(of color: GoodsColour) -> [GoodsCard] {
        return marketCards.filter { $0.color == color }
    }
    
    public func getAllCards() -> [GoodsCard] {
        return marketCards
    }
    
    public func getCardCount(of color: GoodsColour) -> Int {
        return getCards(of: color).count
    }
}

public class MerchantsGame: ObservableObject {
    @Published public var gameState: GameState = .setup
    @Published public var currentPhase: GamePhase = .purchase
    @Published public var activePlayerIndex: Int = 0 // Player on turn

    /// Game components
    public var deck: Deck = Deck()
    public var marketplace: Marketplace = Marketplace()
    public var players: [Player] = []

    /// Supply of goods cubes and special building cards
    var goodsCubes: [GoodsColour: [GoodsCube]] = [:]
    var specialBuildingCards: [SpecialBuildingTypes: [SpecialBuildingCard]] = [:]

    public init() {
        setupSupply()
    }

    // Setup the supply of cubes, special buildings, etc.
    private func setupSupply() {
        /// Create goods cubes (5 of each color)
        for color in GoodsColour.allCases {
            goodsCubes[color] = []
            for _ in 0..<5 {
                goodsCubes[color]?.append(GoodsCube(color: color))
            }
            print("Created \(goodsCubes[color]?.count ?? 0) \(color.description) cubes")
        }
        
        /// Create special building cards
        for buildingType in SpecialBuildingTypes.allCases {
            specialBuildingCards[buildingType] = []
            
            let count: Int
            switch buildingType {
            case .ship: count = 14
            case .office: count = 2
            case .warehouse: count = 2
            case .forklift: count = 2
            case .crane: count = 2
            }
            
            for _ in 0..<count {
                specialBuildingCards[buildingType]?.append(SpecialBuildingCard(buildingType: buildingType))
            }
            
            print("Created \(specialBuildingCards[buildingType]?.count ?? 0) \(buildingType.description) cards")
        }
    }

    /// Setup the game with players, initial hands, ships, and marketplace
    public func setupGame() {
        print("=== Starting game setup ===")
        
        // Create players
        createPlayers()
        print("Created \(players.count) players")
        
        // Setup supply
        setupSupply()
        print("Supply setup complete")
        
        // Shuffle deck and prepare the marketplace with 6 cards
        deck.shuffle()
        marketplace.setupMarketplace(from: deck)
        print("Deck shuffled and marketplace created")
        
        // Deal initial cards
        dealInitialCards()
        print("Initial cards dealt")                
        
        // Set first player
        activePlayerIndex = 0
        players[activePlayerIndex].isOnTurn = true
        print("First player set: Player \(activePlayerIndex + 1)")
        
        gameState = .playing
        print("=== Game setup complete ===")
    }


    private func createPlayers() {
        players.removeAll()
        
        for i: Int in 0..<GameRules.Player.maxCount {
            let player: Player = Player()
            player.coins = GameRules.Economy.startingCoins 
            players.append(player)
            print("Created Player \(i + 1) with ID: \(player.id)")
        }
    }
    
    private func dealInitialCards() {
        for player: Player in players {
            let cards: [GoodsCard] = deck.drawCards(GameRules.Economy.startingHandSize)
            for card in cards {
                player.addGoodsCard(card)
            }
            print("Dealt \(cards.count) cards to player \(player.id)")
        }
    }
    
    public func nextTurn() {
        // End current player's turn
        players[activePlayerIndex].isOnTurn = false
        
        // Move to next player
        activePlayerIndex = (activePlayerIndex + 1) % players.count
        
        // Set new current player
        players[activePlayerIndex].isOnTurn = true
        
        // Reset phase
        currentPhase = .purchase
        
        print("Player \(activePlayerIndex + 1) is now active")
        
        // Check for game end
        if deck.isEmpty {
            print ("Deck is empty, ending game")
            endGame()
        }
    }
    
    public func nextPhase() {
        switch currentPhase {
        case .purchase:
            currentPhase = .delivery
            print("Moving to delivery phase")
        case .delivery:
            nextTurn()
        }
    }

    private func endGame() {
        gameState = .gameOver
        print("=== Game Over ===")
        
        // Find winner
        let winner = getWinner()
        print("Winner: Player \(players.firstIndex(of: winner)! + 1) with \(winner.coins) coins")
        
        // Log final standings
        let sortedPlayers = players.sorted { $0.coins > $1.coins }
        for (index, player) in sortedPlayers.enumerated() {
            let playerNumber = players.firstIndex(of: player)! + 1
            print("\(index + 1). Player \(playerNumber): \(player.coins) coins")
        }
    }
    
    private func getWinner() -> Player {
        return players.max { $0.coins < $1.coins } ?? players[0]
    }

    public var currentPlayer: Player {
        return players[activePlayerIndex]
    }
    
    public var canEndGame: Bool {
        return deck.isEmpty
    }
    
    public func getPlayerRankings() -> [(player: Player, rank: Int, coins: Int)] {
        let sortedPlayers = players.sorted { $0.coins > $1.coins }
        return sortedPlayers.enumerated().map { (index, player) in
            (player: player, rank: index + 1, coins: player.coins)
        }
    }
    
}

/// On their turn, a player can:
/// - `PURCHASE PHASE`:
///     - Exchange a cube on a ship for another color
///     -  Buy a special building card
///     - Pass (Only during Phase: Purchase)
/// - `DELIVERY PHASE`:
///     - Make a delivery
///     - Draw cards
//
public class GameActionHandler {
    private var game: MerchantsGame
    private var phase: GamePhase {
        return game.currentPhase
    }
    
    public init(game: MerchantsGame) {
        self.game = game
    }

    public func handleAction(player: Player, action: PlayerAction) -> Bool {
        switch action {
        case .exchangeCubes:
            // Implement exchange cubes logic
            return true
        case .buySpecialCard:
            // Implement buy special card logic
            return true
        case .pass:
            // Implement pass logic
            return true
        case .makeDelivery:
            // Implement make delivery logic
            return true
        case .drawCards:
            // Implement draw cards logic
            return true
        }
    }


    // #TODO
    public func makePayouts() {

    }
}

