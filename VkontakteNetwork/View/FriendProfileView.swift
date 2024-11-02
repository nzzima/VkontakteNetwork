//
//  FriendProfileView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 18.10.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct FriendProfileView: View {
    @EnvironmentObject var dataSource: DataSource
    let friendCore: FriendCore
    var body: some View {
        ZStack {
            Color(dataSource.selectedTheme.primaryColor)
                .ignoresSafeArea()
            ScrollView(.vertical) {
                Text("Profile")
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                LazyVStack {
                    HStack {
                        Text(friendCore.firstName ?? "")
                            .font(.system(size: 18))
                            .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                            .fontWeight(.black)
                        Text(friendCore.lastName ?? "")
                            .font(.system(size: 18))
                            .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                            .fontWeight(.black)
                    }
                    .padding(.top, 20)
                    WebImage(url: URL(string: friendCore.photo ?? ""))
                        .resizable()
                        .frame(width: 270, height: 300)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    FriendProfileView(friendCore: FriendCore())
}
