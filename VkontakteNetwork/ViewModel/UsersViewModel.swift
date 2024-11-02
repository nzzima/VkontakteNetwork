//
//  UsersViewModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 13.09.2024.
//

import Foundation
import Alamofire

class UsersViewModel: ObservableObject {
    func getUsers(token: String, completion: @escaping ([User]) -> Void) {
        let urlLink = "https://api.vk.com/method/users.get"
        let params = [
            "access_token": token,
            "fields": "photo_max_orig,screen_name",
            "v": "5.199"
        ] as [String : AnyObject]
        AF.request(urlLink, method: .post, parameters: params).response {result  in
            if let data = result.data {
                if let users = try? JSONDecoder().decode(UsersResponse.self, from: data).response {
                    completion(users)
                }
            }
        }
    }
}
