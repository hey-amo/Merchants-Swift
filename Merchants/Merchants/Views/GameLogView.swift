//
//  GameLogView.swift
//  Merchants
//
//  Created by Amarjit on 28/08/2025.
//

import SwiftUI
import MerchantsEngine

// Assessment:
// - For up to 500 rows, SwiftUI's List is performant and lazily renders cells with reuse.
// - Using a plain List is preferable to a ScrollView + LazyVStack for dynamic insertions and memory reuse.
// - A UIKit UITableView via UIViewRepresentable is unnecessary overhead at this scale.
// Decision: Use SwiftUI List with lightweight rows and a capped buffer.

struct GameLogEntry: Identifiable, Hashable {
    let id: UUID = UUID()
    let timestamp: Date
    let text: String
}

final class GameLogStore: ObservableObject {
    @Published private(set) var entries: [GameLogEntry] = []
    private let capacity: Int = 500

    func append(_ text: String) {
        let entry = GameLogEntry(timestamp: Date(), text: text)
        entries.insert(entry, at: 0) // newest first
        if entries.count > capacity {
            entries.removeLast(entries.count - capacity)
        }
    }

    func clear() {
        entries.removeAll(keepingCapacity: true)
    }
}

struct GameLogView: View {
    @StateObject private var store = GameLogStore()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Game Log")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {
                    store.clear()
                    print("GameLog: Clear pressed")
                }) {
                    Label("Clear", systemImage: "trash")
                }
                .buttonStyle(.bordered)
            }
            .padding()

            List(store.entries) { entry in
                GameLogRow(entry: entry)
                    .listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            }
            .listStyle(.plain)
        }
        .onAppear {
            // Sample data for preview/testing
            if store.entries.isEmpty {
                (1...12).forEach { i in store.append("Sample log message #\(i)") }
            }
        }
    }
}

private struct GameLogRow: View {
    let entry: GameLogEntry

    private static let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .medium
        return df
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.text)
                .font(.body)
            Text(Self.formatter.string(from: entry.timestamp))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    GameLogView()
}
