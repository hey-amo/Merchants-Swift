//
//  MerchantsApp.swift
//  Merchants
//
//  Created by Amarjit on 31/10/2025.
//

import SwiftUI

@main
struct MerchantsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
