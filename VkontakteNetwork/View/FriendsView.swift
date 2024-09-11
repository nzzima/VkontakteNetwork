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
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var friendsViewModel = FriendsViewModel()
    @State var friends = [Friend]()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(friends, id: \.self) { friend in
                        FriendItem(name: friend.firstName, surname: friend.lastName, photo: friend.photo)
                    }
                }
                .padding(10)
            }
        }
        .padding(.top, 50)
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
    var name: String
    var surname: String
    var photo: String
    //var online: Int?
    
    var body: some View{
        HStack{
            WebImage(url: URL(string: photo))
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 18))
            }
            Text(surname)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}
