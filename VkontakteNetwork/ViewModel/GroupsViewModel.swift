//
//  GroupsViewModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 09.09.2024.
//

import Foundation
import Alamofire

class GroupsViewModel: ObservableObject {
    func getGroups(token: String, completion: @escaping ([Group]) -> Void) {
        let urlLink = "https://api.vk.com/method/groups.get"
        let params = [
            "access_token": token,
            "extended": 1,
            "fields": "photo_50",
            "v": "5.199",
            "count": 30
        ] as [String : AnyObject]
        AF.request(urlLink, method: .post, parameters: params).response {result  in
            if let data = result.data {
                if let groups = try? JSONDecoder().decode(GroupResponse.self, from: data).response.items {
                    completion(groups)
                }
            }
        }
    }
}
