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
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var groupsViewModel = GroupsViewModel()
    @State var groups = [Group]()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                Text("Groups")
                LazyVStack {
                    ForEach(groups, id: \.self) { group in
                            GroupItem(name: group.name, photo: group.photo)
                    }
                }
                .padding(10)
            }
        }
        .padding(.top, 1)
        .padding(.bottom, 15)
        .onAppear{
            groupsViewModel.getGroups(token: loginViewModel.token) {groups in
                self.groups = groups
                print(groups) //Groups information in console
            }
        }
    }
}

#Preview {
    GroupsView()
}

struct GroupItem: View {
    var name: String
    var photo: String
    
    var body: some View{
        HStack{
            WebImage(url: URL(string: photo))
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 18))
                    .padding(.bottom, 2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}
