//
//  UsersModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 13.09.2024.
//

import Foundation

struct UsersResponse: Decodable {
    var response: [User]
}

struct User: Decodable, Hashable {
    var photo: String
    var screenName: String
    var firstName: String
    var lastName: String
    enum CodingKeys: String, CodingKey {
        case photo = "photo_max_orig"
        case screenName = "screen_name"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
