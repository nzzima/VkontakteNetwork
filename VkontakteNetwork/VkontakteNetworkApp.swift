//
//  VkontakteNetworkApp.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI

@main
struct VkontakteNetworkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataSource())
        }
    }
}
