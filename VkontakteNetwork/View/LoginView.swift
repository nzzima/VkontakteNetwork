//
//  LoginView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var dataSource: DataSource
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        if loginViewModel.isLogin {
            AppView()
                .environmentObject(loginViewModel)
        } else {
            WebView(token: $loginViewModel.token)
        }
    }
}

#Preview {
    LoginView()
}
