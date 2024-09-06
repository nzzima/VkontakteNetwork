//
//  AppView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI

struct AppView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var friendsViewModel = FriendsViewModel()
    @State var friends = [Friend]()
    
    var body: some View {
        ZStack {
            ScrollView() {
                VStack {
                    
                }
                .padding(10)
            }
        }
        .padding(30)
        .onAppear{
            friendsViewModel.getFriends(token: loginViewModel.token) {friends in
                self.friends = friends
                print(friends)
            }
        }
    }
}
