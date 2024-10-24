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
    
    @EnvironmentObject var manager: CoreDataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var friendsCore: FetchedResults<FriendCore>
    
    var body: some View {
        if friendsCore.isEmpty {
            ForEach(friends, id: \.self) { friend in
                let _ = addNewFriend(photo: friend.photo, firstname: friend.firstName, lastname: friend.lastName, online: friend.online)
            }
        } else {
            let _ = updateFriends(friends: friends)
        }
        let _ = print("Already \(friendsCore.count) saved!")
        
//        ZStack {
//            Color(dataSource.selectedTheme.primaryColor)
//                .ignoresSafeArea()
//            ScrollView(.vertical) {
//                Text("Friends")
//                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
//                VStack {
//                    ForEach(friendsCore, id: \.self) { friendCore in
//                        FriendItemCore(friendCore: friendCore, name: friendCore.firstName ?? "", surname: friendCore.lastName ?? "", photo: friendCore.photo ?? "", online: Int(friendCore.status))
//                    }
//                }
//                .padding(10)
//            }
//            .padding(.top, 1)
//        }
//        .padding(.bottom, 15)
//        .onAppear{
//            friendsViewModel.getFriends(token: loginViewModel.token) {friends in
//                self.friends = friends
//                //print(friends) //Friends information in console
//            }
//        }
//        .refreshable {
//            refreshing()
//        }
        ZStack {
            Color(dataSource.selectedTheme.primaryColor)
                .ignoresSafeArea()
            NavigationStack {
                List(friendsCore) { friendCore in
                    NavigationLink(destination: FriendProfileView(friendCore: friendCore)) {
                        FriendItemCore(friendCore: friendCore, name: friendCore.firstName ?? "", surname: friendCore.lastName ?? "", photo: friendCore.photo ?? "", online: Int(friendCore.status))
                    }
                    .background(Color(dataSource.selectedTheme.primaryColor))
                }
                .listStyle(.grouped)
                .padding(.bottom, 40)
                .scrollContentBackground(.hidden)
                .background(Color(dataSource.selectedTheme.primaryColor))
            }
            .padding(.top, 1)
            .background(Color(dataSource.selectedTheme.primaryColor))
        }
        .onAppear{
            friendsViewModel.getFriends(token: loginViewModel.token) {friends in
                self.friends = friends
            }
        }
        .refreshable {
            refreshing()
        }

    }
    func addNewFriend(photo: String, firstname: String, lastname: String, online: Int64) {
        let friendModel = Friend(photo: photo, firstname: firstname, lastname: lastname, online: online)
        CoreDataManager.shared.saveFriend(friendModel: friendModel)
    }
    
    func updateFriends(friends: [Friend]) {
        CoreDataManager.shared.updateFriends(newFriends: friends)
    }
    
    func refreshing() {
        print("Refresh START!")
        let _ = updateFriends(friends: friends)
        print("Refresh FINISH!")
    }
}

#Preview {
    FriendsView()
        .environmentObject(DataSource())
}

struct FriendItemCore: View {
    @EnvironmentObject var dataSource: DataSource
    var friendCore: FriendCore
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
        .background(Color(dataSource.selectedTheme.primaryColor))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}
