//
//  GroupsView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 09.09.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct GroupsView: View {
    @EnvironmentObject var dataSource: DataSource
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var groupsViewModel = GroupsViewModel()
    @State var groups = [Group]()
    var body: some View {
        ZStack {
            Color(dataSource.selectedTheme.primaryColor)
                .ignoresSafeArea()
            ScrollView(.vertical) {
                Text("Groups")
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                LazyVStack {
                    ForEach(groups, id: \.self) { group in
                        GroupItemCore(name: group.name, photo: group.photo)
                    }
                }
                .padding(10)
            }
            .padding(.top, 1)
        }
        .padding(.bottom, 15)
        .onAppear {
            groupsViewModel.getGroups(token: loginViewModel.token) {groups in
                self.groups = groups
            }
        }
    }
}
    #Preview {
        GroupsView()
            .environmentObject(DataSource())
    }
    struct GroupItemCore: View {
        @EnvironmentObject var dataSource: DataSource
        var name: String
        var photo: String
        var body: some View {
            HStack {
                WebImage(url: URL(string: photo))
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 18))
                        .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                        .padding(.bottom, 2)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
        }
    }
