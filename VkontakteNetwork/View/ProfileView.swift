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
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var usersViewModel = UsersViewModel()
    @State var users = [User]()
    var body: some View {
        ZStack {
            Color(dataSource.selectedTheme.primaryColor)
                .ignoresSafeArea()
            ScrollView(.vertical) {
                Text("Profile")
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                LazyVStack {
                    ForEach(users, id: \.self) { user in
                        UserItem(name: user.firstName, surname: user.lastName, photo: user.photo)
                    }
                    ForEach(0..<ThemeManager.themes.count, id: \.self) { theme in
                        Button(ThemeManager.themes[theme].themeName) {
                            dataSource.selectedThemeAs = theme
                            presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                        .background(Color.green)
                        .clipShape(Capsule())
                        .foregroundStyle(Color.black)
                    }
                }
            }
        }
        .onAppear {
            usersViewModel.getUsers(token: loginViewModel.token) {users in
                self.users = users
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(DataSource())
}

struct UserItem: View {
    @EnvironmentObject var dataSource: DataSource
    var name: String
    var surname: String
    var photo: String
    var body: some View {
        LazyVStack {
            HStack {
                Text(name)
                    .font(.system(size: 18))
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                    .fontWeight(.black)
                Text(surname)
                    .font(.system(size: 18))
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
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
