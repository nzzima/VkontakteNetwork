//
//  ThemeDefinitions.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 27.09.2024.
//

import UIKit

struct SoftTheme: Theme {
    var primaryColor: UIColor = UIColor(named: "SoftPrimaryColor")!
    var secondaryColor: UIColor = UIColor(named: "SoftSecondaryColor")!
    var labelColor: UIColor = UIColor(named: "SoftLabelColor")!
    var themeName: String = "Soft Theme"
}

struct DarkTheme: Theme {
    var primaryColor: UIColor = UIColor(named: "DarkPrimaryColor")!
    var secondaryColor: UIColor = UIColor(named: "DarkSecondaryColor")!
    var labelColor: UIColor = UIColor(named: "DarkLabelColor")!
    var themeName: String = "Dark Theme"
}

struct LightTheme: Theme {
    var primaryColor: UIColor = UIColor(named: "LightPrimaryColor")!
    var secondaryColor: UIColor = UIColor(named: "LightSecondaryColor")!
    var labelColor: UIColor = UIColor(named: "LightLabelColor")!
    var themeName: String = "Light Theme"
}
