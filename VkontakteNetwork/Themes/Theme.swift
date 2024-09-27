//
//  Theme.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 27.09.2024.
//

import UIKit

protocol Theme {
    var primaryColor: UIColor {get}
    var secondaryColor:  UIColor {get}
    var labelColor: UIColor {get}
    var themeName: String {get}
}
