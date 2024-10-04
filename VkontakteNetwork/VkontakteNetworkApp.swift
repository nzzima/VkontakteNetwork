//
//  VkontakteNetworkApp.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI

@main
struct VkontakteNetworkApp: App {
    @StateObject private var manager: CoreDataManager = CoreDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataSource())
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.persistentContainer.viewContext)
        }
    }
}
