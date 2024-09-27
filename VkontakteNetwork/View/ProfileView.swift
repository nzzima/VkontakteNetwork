//
//  ProfileView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 12.09.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataSource: DataSource
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var usersViewModel = UsersViewModel()
    @State var users = [User]()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                Text("Profile")
                LazyVStack {
                    ForEach(users, id: \.self) { user in
                        UserItem(name: user.firstName, surname: user.lastName, photo: user.photo)
                    }
                }
            }
        }
        .onAppear{
            usersViewModel.getUsers(token: loginViewModel.token) {users in
                self.users = users
                print(users) //Users information in console
            }
        }
    }
}

#Preview {
    ProfileView()
}

struct UserItem: View {
    var name: String
    var surname: String
    var photo: String
    
    var body: some View{
        LazyVStack{
            HStack {
                Text(name)
                    .font(.system(size: 18))
                    .fontWeight(.black)
                Text(surname)
                    .font(.system(size: 18))
                    .fontWeight(.black)
            }
            .padding(.top, 20)
            WebImage(url: URL(string: photo))
                .resizable()
                .frame(width: 270, height: 300)
                .clipShape(Circle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}
