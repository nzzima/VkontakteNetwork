//
//  PhotosModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 10.09.2024.
//

import Foundation

struct PhotoResponse: Decodable {
    var response: Photos
}

struct Photos: Decodable {
    var items: [Photo]
}

struct Photo: Decodable, Hashable {
    var likes: String
    
    enum CodingKeys: String, CodingKey{
        case likes = "likes"
    }
}
