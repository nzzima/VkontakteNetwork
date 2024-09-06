//
//  LoginViewModel.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import UIKit

class LoginViewModel: ObservableObject {
    @Published var isLogin = false
    
    @Published var token = "" {
        didSet{
            isLogin = true
        }
    }
}
