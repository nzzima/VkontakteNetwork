//
//  DataSource.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 27.09.2024.
//

import Foundation

class DataSource: ObservableObject {
    @Published var selectedTheme: Theme = SoftTheme()
}
