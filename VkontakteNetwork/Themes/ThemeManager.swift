//
//  ThemeManager.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 27.09.2024.
//

import Foundation

enum ThemeManager {
    static let themes: [Theme] = [SoftTheme(), DarkTheme(), LightTheme()]
    static func getTheme(_ theme: Int) -> Theme {
        Self.themes[theme]
    }
}
