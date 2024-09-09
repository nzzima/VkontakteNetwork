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
    
//    @EnvironmentObject var loginViewModel: LoginViewModel
//    @ObservedObject var friendsViewModel = FriendsViewModel()
//    @State var friends = [Friend]()
    
    var body: some View {
//        ZStack {
//            ScrollView(.vertical) {
//                LazyVStack {
//                    ForEach(friends, id: \.self) { friend in
//                        FriendItem(name: friend.firstName, surname: friend.lastName, photo: friend.photo)
//                    }
//                }
//                .padding(10)
//            }
//        }
//        .padding(.top, 50)
//        .onAppear{
//            friendsViewModel.getFriends(token: loginViewModel.token) {friends in
//                self.friends = friends
//                print(friends)
//            }
//        }
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

//struct FriendItem: View {
//    var name: String
//    var surname: String
//    var photo: String
//    
//    var body: some View{
//        HStack{
//            WebImage(url: URL(string: photo))
//                .resizable()
//                .frame(width: 50, height: 50)
//                .clipShape(Circle())
//            VStack(alignment: .leading) {
//                Text(name)
//                    .font(.system(size: 18, weight: .black))
//                    .padding(.bottom, 2)
//                Text(surname)
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(.bottom, 8)
//    }
//}
