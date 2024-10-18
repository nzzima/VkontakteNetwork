//
//  VkontakteNetworkApp.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI

@main
struct VkontakteNetworkApp: App {
    @StateObject var manager = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataSource())
                .environment(\.managedObjectContext, manager.persistentContainer.viewContext)
        }
    }
}
