//
//  FriendsModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import Foundation

struct FriendResponse: Decodable {
    var response: Friends
}

struct Friends: Decodable {
    var items: [Friend]
}

struct Friend: Decodable, Hashable {
    var photo: String
    var firstName: String
    var lastName: String
    var online: Int!
    
    enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
}
