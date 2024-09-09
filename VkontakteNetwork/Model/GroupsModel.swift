//
//  GroupsModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 09.09.2024.
//

import Foundation

struct GroupResponse: Decodable {
    var response: Groups
}

struct Groups: Decodable {
    var items: [Group]
}

struct Group: Decodable, Hashable {
    var photo: String
    var title: String
    
    enum CodingKeys: String, CodingKey{
        case title = "title"
        case photo = "photo_50"
    }
}
