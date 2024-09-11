//
//  PhotosViewModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 10.09.2024.
//

import Foundation
import Alamofire

class PhotosViewModel: ObservableObject {
    func getPhotos(token: String, completion: @escaping ([Photo]) -> ()) {
        let url = "https://api.vk.com/method/photos.get"
        
        let params = [
            "access_token": token,
            "album_id": "wall",
            "v": "5.199",
            "count": 20
        ] as [String : AnyObject]
        
        AF.request(url, method: .post, parameters: params).response {result  in
            if let data = result.data {
                if let photos = try? JSONDecoder().decode(PhotoResponse.self, from: data).response.items
                {
                    completion(photos)
                }
            }
        }
    }
}
