//
//  GameModel.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//
import Foundation
import GameplayKit
import SwiftUI

// MARK: - Enums and Constants

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
    public static func systemColor(for colour: GoodsColour) -> Color {
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


public enum GameState: CaseIterable {
    case setup, playing, gameOver
    
    public var description: String {
        switch self {
        case .setup: return "Setup"
        case .playing: return "Playing"
        case .gameOver: return "Game Over"
        }
    }
}

public enum GamePhase: CaseIterable {
    case purchase, delivery
    
    public var description: String {
        switch self {
        case .purchase: return "Purchase"
        case .delivery: return "Delivery"
        }
    }
}

public enum PlayerAction: CaseIterable {
    case exchangeCube, buySpecialCard, pass, makeDelivery, drawCards
    
    public var description: String {
        switch self {
        case .exchangeCube: return "Exchange Cube"
        case .buySpecialCard: return "Buy Special Card"
        case .pass: return "Pass"
        case .makeDelivery: return "Make a Delivery"
        case .drawCards: return "Draw Cards"
        }
    }
}

// MARK: - Core Game Objects

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

public struct Ship: Identifiable, Equatable, Hashable {
    public let id = UUID()
    public var goodsCube: GoodsCube?
    
    public var isEmpty: Bool {
        return goodsCube == nil
    }
    
    public var isLoaded: Bool {
        return goodsCube != nil
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

// MARK: - Bank Class

public class Bank {
    public init() {}
    
    public func canAfford(player: Player, amount: Int) -> Bool {
        return player.coins >= amount
    }
    
    public func debit(player: Player, amount: Int) -> Bool {
        guard canAfford(player: player, amount: amount) else {
            print("Player \(player.id) cannot afford \(amount) coins")
            return false
        }
        
        player.coins -= amount
        print("Debited \(amount) coins from player \(player.id). New balance: \(player.coins)")
        return true
    }
    
    public func credit(player: Player, amount: Int) {
        player.coins += amount
        print("Credited \(amount) coins to player \(player.id). New balance: \(player.coins)")
    }
}

// MARK: - Player Class

public class Player: Identifiable, Equatable {
    public init() {}
    
    public let id = UUID()
    public var coins: Int = 0
    public var cards: [GoodsCard] = []
    public var specialBuildings: [SpecialBuildingCard] = []
    public var ships: [Ship] = []
    public var isOnTurn: Bool = false
    public var avatar: Avatar?
    
    public var hand: [GoodsCard] {
        return self.cards
    }
    
    public var handSize: Int {
        let baseHandSize = 6
        let warehouseBonus = specialBuildings.filter { $0.buildingType == .warehouse }.count * 2
        return baseHandSize + warehouseBonus
    }
    
    public var maxShips: Int {
        let baseShips = 2
        let shipBonus = specialBuildings.filter { $0.buildingType == .ship }.count
        return baseShips + shipBonus
    }
    
    public var canExchangeExtraCube: Bool {
        return specialBuildings.contains { $0.buildingType == .crane }
    }
    
    public var deliveryBonus: Int {
        return specialBuildings.filter { $0.buildingType == .office }.count * 2
    }
    
    public var drawBonus: Int {
        return specialBuildings.filter { $0.buildingType == .forklift }.count
    }
    
    public func addCard(_ card: GoodsCard) {
        cards.append(card)
    }
    
    public func removeCard(_ card: GoodsCard) -> Bool {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
            return true
        }
        return false
    }
    
    public func addSpecialBuilding(_ building: SpecialBuildingCard) {
        specialBuildings.append(building)
    }
    
    public func addShip(_ ship: Ship) {
        ships.append(ship)
    }
    
    public func loadShip(_ ship: Ship, with cube: GoodsCube) -> Bool {
        guard let shipIndex = ships.firstIndex(of: ship) else { return false }
        guard ships[shipIndex].isEmpty else { return false }
        
        ships[shipIndex].goodsCube = cube
        return true
    }
    
    public func unloadShip(_ ship: Ship) -> GoodsCube? {
        guard let shipIndex = ships.firstIndex(of: ship) else { return nil }
        let cube = ships[shipIndex].goodsCube
        ships[shipIndex].goodsCube = nil
        return cube
    }
    
    public func getGoodsCubes() -> [GoodsCube] {
        return ships.compactMap { $0.goodsCube }
    }
    
    public func getGoodsCubes(of color: GoodsColour) -> [GoodsCube] {
        return getGoodsCubes().filter { $0.color == color }
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Deck Class

public class Deck {
    private var cards: [GoodsCard] = []
    
    public init() {
        createDeck()
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
        
        // Draw 6 cards to create 2x3 marketplace
        let drawnCards = deck.drawCards(6)
        marketCards = drawnCards
        
        print("Marketplace setup with \(marketCards.count) cards")
        for card in marketCards {
            print("Marketplace card: \(card.color.description)")
        }
    }
    
    // # This is wrong
    // When we add cards, we only play cards ontop of existing cards.
    public func addCards(_ cards: [GoodsCard]) {
        marketCards.append(contentsOf: cards)
        print("Added \(cards.count) cards to marketplace. Total: \(marketCards.count)")
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

// MARK: - Game Model

public class MerchantsGame: ObservableObject {
    // Game state
    @Published public var gameState: GameState = .setup
    @Published public var currentPhase: GamePhase = .purchase
    @Published public var currentPlayerIndex: Int = 0
    @Published public var turnNumber: Int = 1
    
    // Game components
    public let deck = Deck()
    public let marketplace = Marketplace()
    public let bank = Bank()
    public var players: [Player] = []
    
    // Game constants
    let maxPlayers = 4
    let startingCoins = 0
    let startingShips = 2
    let startingHandSize = 3
    
    // Supply
    var goodsCubes: [GoodsColour: [GoodsCube]] = [:]
    var specialBuildingCards: [SpecialBuildingTypes: [SpecialBuildingCard]] = [:]
    
    public init() {
        setupSupply()
    }
    
    // MARK: - Game Setup
    
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
        
        // Setup ships and load with cubes
        setupShips()
        print("Ships setup and loaded with cubes")
        
        // Set first player
        currentPlayerIndex = 0
        players[currentPlayerIndex].isOnTurn = true
        print("First player set: Player \(currentPlayerIndex + 1)")
        
        gameState = .playing
        print("=== Game setup complete ===")
    }
    
    private func createPlayers() {
        players.removeAll()
        
        for i in 0..<maxPlayers {
            let player = Player()
            player.coins = startingCoins
            players.append(player)
            print("Created Player \(i + 1) with ID: \(player.id)")
        }
    }
    
    private func setupSupply() {
        // Create goods cubes (5 of each color)
        for color in GoodsColour.allCases {
            goodsCubes[color] = []
            for _ in 0..<5 {
                goodsCubes[color]?.append(GoodsCube(color: color))
            }
            print("Created \(goodsCubes[color]?.count ?? 0) \(color.description) cubes")
        }
        
        // Create special building cards
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
    
    private func dealInitialCards() {
        for player in players {
            let cards = deck.drawCards(startingHandSize)
            for card in cards {
                player.addCard(card)
            }
            print("Dealt \(cards.count) cards to player \(player.id)")
        }
    }
    
    private func setupShips() {
        for player in players {
            // Give each player 2 ships
            for _ in 0..<startingShips {
                player.addShip(Ship())
            }
            
            // Load ships with cubes using snake draft
            loadShipsWithSnakeDraft(for: player)
        }
    }
    
    private func loadShipsWithSnakeDraft(for player: Player) {
        // Snake draft: last player picks first, then clockwise, then reverse
        let playerIndex = players.firstIndex(of: player) ?? 0
        
        print ("player index: \(playerIndex)")
        
        // For now, just load with random cubes (simplified)
        let availableColors = GoodsColour.allCases
        for ship in player.ships {
            if let randomColor = availableColors.randomElement(),
               let cube = goodsCubes[randomColor]?.popLast() {
                let _ = player.loadShip(ship, with: cube)
                print("Loaded \(randomColor.description) cube onto ship for player \(player.id)")
            }
        }
    }
    
    // MARK: - Game Flow
    
    public func nextTurn() {
        // End current player's turn
        players[currentPlayerIndex].isOnTurn = false
        
        // Move to next player
        currentPlayerIndex = (currentPlayerIndex + 1) % players.count
        
        // If we've completed a full round, increment turn number
        if currentPlayerIndex == 0 {
            turnNumber += 1
        }
        
        // Set new current player
        players[currentPlayerIndex].isOnTurn = true
        
        // Reset phase
        currentPhase = .purchase
        
        print("Turn \(turnNumber), Player \(currentPlayerIndex + 1) is now active")
        
        // Check for game end
        if deck.isEmpty {
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
    
    // MARK: - Game Actions
    
    public func exchangeCube(player: Player, ship: Ship, newColor: GoodsColour) -> Bool {
        guard currentPhase == .purchase else {
            print("Cannot exchange cube during delivery phase")
            return false
        }
        
        guard let cube = player.unloadShip(ship) else {
            print("Ship is empty, cannot exchange")
            return false
        }
        
        guard let newCube = goodsCubes[newColor]?.popLast() else {
            print("No \(newColor.description) cubes available")
            // Put the original cube back
            let _ =  player.loadShip(ship, with: cube)
            return false
        }
        
        // Return original cube to supply
        goodsCubes[cube.color]?.append(cube)
        
        // Load new cube
        let _ = player.loadShip(ship, with: newCube)
        
        print("Player \(player.id) exchanged \(cube.color.description) cube for \(newColor.description) cube")
        return true
    }
    
    public func buySpecialCard(player: Player, buildingType: SpecialBuildingTypes) -> Bool {
        guard currentPhase == .purchase else {
            print("Cannot buy special card during delivery phase")
            return false
        }
        
        guard var availableCards = specialBuildingCards[buildingType], !availableCards.isEmpty else {
            print("No \(buildingType.description) cards available")
            return false
        }
        
        let cost = buildingType.cost
        
        guard bank.canAfford(player: player, amount: cost) else {
            print("Player \(player.id) cannot afford \(buildingType.description)")
            return false
        }
        
        // Process purchase
        let card = availableCards.removeFirst()
        specialBuildingCards[buildingType] = availableCards
        
        let _ = bank.debit(player: player, amount: cost)
        player.addSpecialBuilding(card)
        
        print("Player \(player.id) bought \(buildingType.description) for \(cost) coins")
        
        // If it's a ship, immediately load it with a cube
        if buildingType == .ship {
            if let randomColor = GoodsColour.allCases.randomElement(),
               let cube = goodsCubes[randomColor]?.popLast() {
                let newShip = Ship()
                player.addShip(newShip)
                let _ = player.loadShip(newShip, with: cube)
                print("New ship loaded with \(randomColor.description) cube")
            }
        }
        
        return true
    }
    
    public func makeDelivery(player: Player, cards: [GoodsCard]) -> Bool {
        guard currentPhase == .delivery else {
            print("Cannot make delivery during purchase phase")
            return false
        }
        
        guard !cards.isEmpty else {
            print("Cannot make delivery with no cards")
            return false
        }
        
        // Check all cards are same color
        let firstColor = cards.first?.color
        guard cards.allSatisfy({ $0.color == firstColor }) else {
            print("All delivery cards must be the same color")
            return false
        }
        
        // Check player has these cards
        for card in cards {
            guard player.cards.contains(card) else {
                print("Player does not have card \(card.id)")
                return false
            }
        }
        
        // Remove cards from player's hand
        for card in cards {
            let _ = player.removeCard(card)
        }
        
        // Add cards to marketplace
        // # note: cards aren't technically being added, but cards are being put on top of existing ones
        marketplace.addCards(cards)
        
        // Calculate and distribute payouts
        let color = firstColor!
        let cardCount = cards.count
        distributePayouts(for: color, cardCount: cardCount)
        
        print("Player \(player.id) delivered \(cardCount) \(color.description) cards")
        
        return true
    }
    
    public func drawCards(player: Player) -> Bool {
        guard currentPhase == .delivery else {
            print("Cannot draw cards during purchase phase")
            return false
        }
        
        let baseDrawCount = 2
        let bonusDrawCount = player.drawBonus
        let totalDrawCount = baseDrawCount + bonusDrawCount
        
        let drawnCards = deck.drawCards(totalDrawCount)
        
        for card in drawnCards {
            player.addCard(card)
        }
        
        print("Player \(player.id) drew \(drawnCards.count) cards (base: \(baseDrawCount), bonus: \(bonusDrawCount))")
        
        return true
    }
    
    private func distributePayouts(for color: GoodsColour, cardCount: Int) {
        let totalCardsInMarket = marketplace.getCardCount(of: color)
                
        for player in players {
            let playerCubes = player.getGoodsCubes(of: color)
            let payout = playerCubes.count * totalCardsInMarket
            
            if payout > 0 {
                bank.credit(player: player, amount: payout)
                print("Player \(player.id) gets \(payout) coins for \(playerCubes.count) \(color.description) cubes")
            }
        }
    }
    
    // MARK: - Game End
    
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
    
    // MARK: - Game State Queries
    
    public var isGameOver: Bool {
        return gameState == .gameOver
    }
    
    public var currentPlayer: Player {
        return players[currentPlayerIndex]
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

// MARK: AI Player
public enum AIStrategy {
    case cubesAndCards
}
