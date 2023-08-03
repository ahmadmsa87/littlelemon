//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Ahmad Saleh on 01/08/2023.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
