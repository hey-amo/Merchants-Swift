//
//  GameModel.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
//
import Foundation
import GameplayKit
import os.log

// MARK: - Enums and Constants

enum GoodsColour: Int, CaseIterable {
    case white = 0, blue = 1, red = 2, green = 3, yellow = 4, brown = 5
    
    var description: String {
        switch self {
        case .white: return "White"
        case .blue: return "Blue"
        case .red: return "Red"
        case .green: return "Green"
        case .yellow: return "Yellow"
        case .brown: return "Brown"
        }
    }
}

enum SpecialBuildingTypes: CaseIterable {
    case ship, office, warehouse, forklift, crane
    
    var cost: Int {
        switch self {
        case .ship: return 10
        case .office: return 8
        case .warehouse: return 15
        case .forklift: return 15
        case .crane: return 12
        }
    }
    
    var description: String {
        switch self {
        case .ship: return "Ship"
        case .office: return "Office"
        case .warehouse: return "Warehouse"
        case .forklift: return "Forklift"
        case .crane: return "Crane"
        }
    }
}

enum GamePhase: CaseIterable {
    case purchase, delivery
    
    var description: String {
        switch self {
        case .purchase: return "Purchase"
        case .delivery: return "Delivery"
        }
    }
}

enum GameState: CaseIterable {
    case setup, playing, gameOver
    
    var description: String {
        switch self {
        case .setup: return "Setup"
        case .playing: return "Playing"
        case .gameOver: return "Game Over"
        }
    }
}

enum PlayerAction: CaseIterable {
    case exchangeCube, buySpecialCard, pass, makeDelivery, drawCards
    
    var description: String {
        switch self {
        case .exchangeCube: return "Exchange Cube"
        case .buySpecialCard: return "Buy Special Card"
        case .pass: return "Pass"
        case .makeDelivery: return "Make Delivery"
        case .drawCards: return "Draw Cards"
        }
    }
}

// MARK: - Core Game Objects

struct GoodsCard: Identifiable, Equatable, Hashable {
    let id = UUID()
    let color: GoodsColour
    
    static func == (lhs: GoodsCard, rhs: GoodsCard) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct GoodsCube: Identifiable, Equatable, Hashable {
    let id = UUID()
    let color: GoodsColour
    
    static func == (lhs: GoodsCube, rhs: GoodsCube) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Ship: Identifiable, Equatable, Hashable {
    let id = UUID()
    var goodsCube: GoodsCube?
    
    var isEmpty: Bool {
        return goodsCube == nil
    }
    
    var isLoaded: Bool {
        return goodsCube != nil
    }
}

struct SpecialBuildingCard: Identifiable, Equatable, Hashable {
    let id = UUID()
    let buildingType: SpecialBuildingTypes
    let name: String
    let action: String
    let cost: Int
    
    init(buildingType: SpecialBuildingTypes) {
        self.buildingType = buildingType
        self.name = buildingType.description
        self.action = buildingType.description
        self.cost = buildingType.cost
    }
}

// MARK: - Bank Class

class Bank {
    private let logger = Logger(subsystem: "com.merchants.game", category: "Bank")
    
    func canAfford(player: Player, amount: Int) -> Bool {
        return player.coins >= amount
    }
    
    func debit(player: Player, amount: Int) -> Bool {
        guard canAfford(player: player, amount: amount) else {
            logger.error("Player \(player.id) cannot afford \(amount) coins")
            return false
        }
        
        player.coins -= amount
        logger.info("Debited \(amount) coins from player \(player.id). New balance: \(player.coins)")
        return true
    }
    
    func credit(player: Player, amount: Int) {
        player.coins += amount
        logger.info("Credited \(amount) coins to player \(player.id). New balance: \(player.coins)")
    }
}

// MARK: - Player Class

class Player: Identifiable, GKGameModelPlayer {
    let id = UUID()
    var coins: Int = 0
    var cards: [GoodsCard] = []
    var specialBuildings: [SpecialBuildingCard] = []
    var ships: [Ship] = []
    var isOnTurn: Bool = false
    
    var handSize: Int {
        let baseHandSize = 6
        let warehouseBonus = specialBuildings.filter { $0.buildingType == .warehouse }.count * 2
        return baseHandSize + warehouseBonus
    }
    
    var maxShips: Int {
        let baseShips = 2
        let shipBonus = specialBuildings.filter { $0.buildingType == .ship }.count
        return baseShips + shipBonus
    }
    
    var canExchangeExtraCube: Bool {
        return specialBuildings.contains { $0.buildingType == .crane }
    }
    
    var deliveryBonus: Int {
        return specialBuildings.filter { $0.buildingType == .office }.count * 2
    }
    
    var drawBonus: Int {
        return specialBuildings.filter { $0.buildingType == .forklift }.count
    }
    
    func addCard(_ card: GoodsCard) {
        cards.append(card)
    }
    
    func removeCard(_ card: GoodsCard) -> Bool {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
            return true
        }
        return false
    }
    
    func addSpecialBuilding(_ building: SpecialBuildingCard) {
        specialBuildings.append(building)
    }
    
    func addShip(_ ship: Ship) {
        ships.append(ship)
    }
    
    func loadShip(_ ship: Ship, with cube: GoodsCube) -> Bool {
        guard let shipIndex = ships.firstIndex(of: ship) else { return false }
        guard ships[shipIndex].isEmpty else { return false }
        
        ships[shipIndex].goodsCube = cube
        return true
    }
    
    func unloadShip(_ ship: Ship) -> GoodsCube? {
        guard let shipIndex = ships.firstIndex(of: ship) else { return nil }
        let cube = ships[shipIndex].goodsCube
        ships[shipIndex].goodsCube = nil
        return cube
    }
    
    func getGoodsCubes() -> [GoodsCube] {
        return ships.compactMap { $0.goodsCube }
    }
    
    func getGoodsCubes(of color: GoodsColour) -> [GoodsCube] {
        return getGoodsCubes().filter { $0.color == color }
    }
}

// MARK: - Deck Class

class Deck {
    private var cards: [GoodsCard] = []
    private let logger = Logger(subsystem: "com.merchants.game", category: "Deck")
    
    init() {
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
        
        logger.info("Created deck with \(cards.count) cards")
    }
    
    func shuffle() {
        cards.shuffle()
        logger.info("Deck shuffled")
    }
    
    func drawCard() -> GoodsCard? {
        guard !cards.isEmpty else { return nil }
        let card = cards.removeFirst()
        logger.info("Drew \(card.color.description) card. Remaining: \(cards.count)")
        return card
    }
    
    func drawCards(_ count: Int) -> [GoodsCard] {
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
    
    var isEmpty: Bool {
        return cards.isEmpty
    }
    
    var remainingCards: Int {
        return cards.count
    }
}

// MARK: - Marketplace Class

class Marketplace {
    private var marketCards: [GoodsCard] = []
    private let logger = Logger(subsystem: "com.merchants.game", category: "Marketplace")
    
    func setupMarketplace(from deck: Deck) {
        marketCards.removeAll()
        
        // Draw 6 cards to create 2x3 marketplace
        let drawnCards = deck.drawCards(6)
        marketCards = drawnCards
        
        logger.info("Marketplace setup with \(marketCards.count) cards")
        for card in marketCards {
            logger.info("Marketplace card: \(card.color.description)")
        }
    }
    
    func addCards(_ cards: [GoodsCard]) {
        marketCards.append(contentsOf: cards)
        logger.info("Added \(cards.count) cards to marketplace. Total: \(marketCards.count)")
    }
    
    func getCards(of color: GoodsColour) -> [GoodsCard] {
        return marketCards.filter { $0.color == color }
    }
    
    func getAllCards() -> [GoodsCard] {
        return marketCards
    }
    
    func getCardCount(of color: GoodsColour) -> Int {
        return getCards(of: color).count
    }
}

// MARK: - Game Model

class MerchantsGame: ObservableObject {
    private let logger = Logger(subsystem: "com.merchants.game", category: "GameModel")
    
    // Game state
    @Published var gameState: GameState = .setup
    @Published var currentPhase: GamePhase = .purchase
    @Published var currentPlayerIndex: Int = 0
    @Published var turnNumber: Int = 1
    
    // Game components
    let deck = Deck()
    let marketplace = Marketplace()
    let bank = Bank()
    var players: [Player] = []
    
    // Game constants
    let maxPlayers = 4
    let startingCoins = 0
    let startingShips = 2
    let startingHandSize = 3
    
    // Supply
    var goodsCubes: [GoodsColour: [GoodsCube]] = [:]
    var specialBuildingCards: [SpecialBuildingTypes: [SpecialBuildingCard]] = [:]
    
    init() {
        setupSupply()
    }
    
    // MARK: - Game Setup
    
    func setupGame() {
        logger.info("=== Starting game setup ===")
        
        // Create players
        createPlayers()
        logger.info("Created \(players.count) players")
        
        // Setup supply
        setupSupply()
        logger.info("Supply setup complete")
        
        // Setup deck and marketplace
        deck.shuffle()
        marketplace.setupMarketplace(from: deck)
        logger.info("Deck shuffled and marketplace created")
        
        // Deal initial cards
        dealInitialCards()
        logger.info("Initial cards dealt")
        
        // Setup ships and load with cubes
        setupShips()
        logger.info("Ships setup and loaded with cubes")
        
        // Set first player
        currentPlayerIndex = 0
        players[currentPlayerIndex].isOnTurn = true
        logger.info("First player set: Player \(currentPlayerIndex + 1)")
        
        gameState = .playing
        logger.info("=== Game setup complete ===")
    }
    
    private func createPlayers() {
        players.removeAll()
        
        for i in 0..<maxPlayers {
            let player = Player()
            player.coins = startingCoins
            players.append(player)
            logger.info("Created Player \(i + 1) with ID: \(player.id)")
        }
    }
    
    private func setupSupply() {
        // Create goods cubes (5 of each color)
        for color in GoodsColour.allCases {
            goodsCubes[color] = []
            for _ in 0..<5 {
                goodsCubes[color]?.append(GoodsCube(color: color))
            }
            logger.info("Created \(goodsCubes[color]?.count ?? 0) \(color.description) cubes")
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
            
            logger.info("Created \(specialBuildingCards[buildingType]?.count ?? 0) \(buildingType.description) cards")
        }
    }
    
    private func dealInitialCards() {
        for player in players {
            let cards = deck.drawCards(startingHandSize)
            for card in cards {
                player.addCard(card)
            }
            logger.info("Dealt \(cards.count) cards to player \(player.id)")
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
        
        // For now, just load with random cubes (simplified)
        let availableColors = GoodsColour.allCases
        for ship in player.ships {
            if let randomColor = availableColors.randomElement(),
               let cube = goodsCubes[randomColor]?.popLast() {
                player.loadShip(ship, with: cube)
                logger.info("Loaded \(randomColor.description) cube onto ship for player \(player.id)")
            }
        }
    }
    
    // MARK: - Game Flow
    
    func nextTurn() {
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
        
        logger.info("Turn \(turnNumber), Player \(currentPlayerIndex + 1) is now active")
        
        // Check for game end
        if deck.isEmpty {
            endGame()
        }
    }
    
    func nextPhase() {
        switch currentPhase {
        case .purchase:
            currentPhase = .delivery
            logger.info("Moving to delivery phase")
        case .delivery:
            nextTurn()
        }
    }
    
    // MARK: - Game Actions
    
    func exchangeCube(player: Player, ship: Ship, newColor: GoodsColour) -> Bool {
        guard currentPhase == .purchase else {
            logger.error("Cannot exchange cube during delivery phase")
            return false
        }
        
        guard let cube = player.unloadShip(ship) else {
            logger.error("Ship is empty, cannot exchange")
            return false
        }
        
        guard let newCube = goodsCubes[newColor]?.popLast() else {
            logger.error("No \(newColor.description) cubes available")
            // Put the original cube back
            player.loadShip(ship, with: cube)
            return false
        }
        
        // Return original cube to supply
        goodsCubes[cube.color]?.append(cube)
        
        // Load new cube
        player.loadShip(ship, with: newCube)
        
        logger.info("Player \(player.id) exchanged \(cube.color.description) cube for \(newColor.description) cube")
        return true
    }
    
    func buySpecialCard(player: Player, buildingType: SpecialBuildingTypes) -> Bool {
        guard currentPhase == .purchase else {
            logger.error("Cannot buy special card during delivery phase")
            return false
        }
        
        guard let availableCards = specialBuildingCards[buildingType], !availableCards.isEmpty else {
            logger.error("No \(buildingType.description) cards available")
            return false
        }
        
        let cost = buildingType.cost
        
        guard bank.canAfford(player: player, amount: cost) else {
            logger.error("Player \(player.id) cannot afford \(buildingType.description)")
            return false
        }
        
        // Process purchase
        let card = availableCards.removeFirst()
        specialBuildingCards[buildingType] = availableCards
        
        bank.debit(player: player, amount: cost)
        player.addSpecialBuilding(card)
        
        logger.info("Player \(player.id) bought \(buildingType.description) for \(cost) coins")
        
        // If it's a ship, immediately load it with a cube
        if buildingType == .ship {
            if let randomColor = GoodsColour.allCases.randomElement(),
               let cube = goodsCubes[randomColor]?.popLast() {
                let newShip = Ship()
                player.addShip(newShip)
                player.loadShip(newShip, with: cube)
                logger.info("New ship loaded with \(randomColor.description) cube")
            }
        }
        
        return true
    }
    
    func makeDelivery(player: Player, cards: [GoodsCard]) -> Bool {
        guard currentPhase == .delivery else {
            logger.error("Cannot make delivery during purchase phase")
            return false
        }
        
        guard !cards.isEmpty else {
            logger.error("Cannot make delivery with no cards")
            return false
        }
        
        // Check all cards are same color
        let firstColor = cards.first?.color
        guard cards.allSatisfy({ $0.color == firstColor }) else {
            logger.error("All delivery cards must be the same color")
            return false
        }
        
        // Check player has these cards
        for card in cards {
            guard player.cards.contains(card) else {
                logger.error("Player does not have card \(card.id)")
                return false
            }
        }
        
        // Remove cards from player's hand
        for card in cards {
            player.removeCard(card)
        }
        
        // Add cards to marketplace
        marketplace.addCards(cards)
        
        // Calculate and distribute payouts
        let color = firstColor!
        let cardCount = cards.count
        distributePayouts(for: color, cardCount: cardCount)
        
        logger.info("Player \(player.id) delivered \(cardCount) \(color.description) cards")
        
        return true
    }
    
    func drawCards(player: Player) -> Bool {
        guard currentPhase == .delivery else {
            logger.error("Cannot draw cards during purchase phase")
            return false
        }
        
        let baseDrawCount = 2
        let bonusDrawCount = player.drawBonus
        let totalDrawCount = baseDrawCount + bonusDrawCount
        
        let drawnCards = deck.drawCards(totalDrawCount)
        
        for card in drawnCards {
            player.addCard(card)
        }
        
        logger.info("Player \(player.id) drew \(drawnCards.count) cards (base: \(baseDrawCount), bonus: \(bonusDrawCount))")
        
        return true
    }
    
    private func distributePayouts(for color: GoodsColour, cardCount: Int) {
        let totalCardsInMarket = marketplace.getCardCount(of: color)
        
        for player in players {
            let playerCubes = player.getGoodsCubes(of: color)
            let payout = playerCubes.count * totalCardsInMarket
            
            if payout > 0 {
                bank.credit(player: player, amount: payout)
                logger.info("Player \(player.id) gets \(payout) coins for \(playerCubes.count) \(color.description) cubes")
            }
        }
    }
    
    // MARK: - Game End
    
    private func endGame() {
        gameState = .gameOver
        logger.info("=== Game Over ===")
        
        // Find winner
        let winner = getWinner()
        logger.info("Winner: Player \(players.firstIndex(of: winner)! + 1) with \(winner.coins) coins")
        
        // Log final standings
        let sortedPlayers = players.sorted { $0.coins > $1.coins }
        for (index, player) in sortedPlayers.enumerated() {
            let playerNumber = players.firstIndex(of: player)! + 1
            logger.info("\(index + 1). Player \(playerNumber): \(player.coins) coins")
        }
    }
    
    private func getWinner() -> Player {
        return players.max { $0.coins < $1.coins } ?? players[0]
    }
    
    // MARK: - Game State Queries
    
    var isGameOver: Bool {
        return gameState == .gameOver
    }
    
    var currentPlayer: Player {
        return players[currentPlayerIndex]
    }
    
    var canEndGame: Bool {
        return deck.isEmpty
    }
    
    func getPlayerRankings() -> [(player: Player, rank: Int, coins: Int)] {
        let sortedPlayers = players.sorted { $0.coins > $1.coins }
        return sortedPlayers.enumerated().map { (index, player) in
            (player: player, rank: index + 1, coins: player.coins)
        }
    }
}
