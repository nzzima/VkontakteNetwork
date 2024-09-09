//
//  AppView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct AppView: View {
    
    var body: some View {
        TabView {
            FriendsView()
                .tag("1")
                .tabItem {
                    Text("Friends")
                }
            GroupsView()
                .tag("2")
                .tabItem {
                    Text("Groups")
                }
            Text("Photos")
                .tag("3")
                .tabItem {
                    Text("Photos")
                }
        }
    }
}
