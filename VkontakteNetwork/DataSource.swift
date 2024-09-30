//
//  DataSource.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 27.09.2024.
//

import Foundation
import SwiftUI

class DataSource: ObservableObject {
    @AppStorage("selectedTheme") var selectedThemeAs = 1 {
        didSet {
            updateTheme()
        }
    }
    
    init() {
        updateTheme()
    }
    
    @Published var selectedTheme: Theme = SoftTheme()
    
    func updateTheme() {
        selectedTheme = ThemeManager.getTheme(selectedThemeAs)
    }
}
