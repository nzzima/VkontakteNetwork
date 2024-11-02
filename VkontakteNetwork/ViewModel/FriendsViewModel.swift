//
//  FriendsViewModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import Foundation
import Alamofire

class FriendsViewModel: ObservableObject {
    func getFriends(token: String, completion: @escaping ([Friend]) -> Void) {
        let urlLink = "https://api.vk.com/method/friends.get"
        let params = [
            "access_token": token,
            "fields": "photo_50,online",
            "v": "5.199",
            "count": 50
        ] as [String : AnyObject]
        AF.request(urlLink, method: .post, parameters: params).response {result  in
            if let data = result.data {
                if let friends = try? JSONDecoder().decode(FriendResponse.self, from: data).response.items {
                    completion(friends)
                }
            }
        }
    }
}
