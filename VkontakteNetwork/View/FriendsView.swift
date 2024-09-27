//
//  FriendsView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 09.09.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct FriendsView: View {
    @EnvironmentObject var dataSource: DataSource
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var friendsViewModel = FriendsViewModel()
    @State var friends = [Friend]()
    
    var body: some View {
        ZStack {
            Color(dataSource.selectedTheme.primaryColor)
                .ignoresSafeArea()
            ScrollView(.vertical) {
                Text("Friends")
                LazyVStack {
                    ForEach(friends, id: \.self) { friend in
                        FriendItem(name: friend.firstName, surname: friend.lastName, photo: friend.photo, online: friend.online)
                    }
                }
                .padding(10)
            }
            .padding(.top, 1)
        }
        //.padding(.top, 1)
        .padding(.bottom, 15)
        .onAppear{
            friendsViewModel.getFriends(token: loginViewModel.token) {friends in
                self.friends = friends
                print(friends) //Friends information in console
            }
        }
    }
}

#Preview {
    FriendsView()
}

struct FriendItem: View {
    @EnvironmentObject var dataSource: DataSource
    var name: String
    var surname: String
    var photo: String
    var online: Int
    
    var body: some View{
        HStack{
            WebImage(url: URL(string: photo))
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 18))
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
            }
            Text(surname)
                .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
            if (online == 1) {
                Text("Online").font(.system(size: 10)).foregroundStyle(.green)
            } else {
                Text("Offline").font(.system(size: 10)).foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}
