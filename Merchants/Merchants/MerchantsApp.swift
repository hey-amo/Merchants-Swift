//
//  MerchantsApp.swift
//  Merchants
//
//  Created by Amarjit on 25/08/2025.
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
