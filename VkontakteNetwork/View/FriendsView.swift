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
    @State var friendModels: [Friend] = []
    
    @EnvironmentObject var manager: CoreDataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var friendsCore: FetchedResults<FriendCore>
    
    var body: some View {
        //let _ = self.manager.deleteAllCoreData() //Очистка CoreData
        
        ForEach(friends, id: \.self) { friend in
            let _ = addNewFriend(photo: friend.photo, firstname: friend.firstName, lastname: friend.lastName, online: friend.online)
        }
        
        let _ = print("Already \(friendsCore.count) saved!")
        
        ZStack {
            Color(dataSource.selectedTheme.primaryColor)
                .ignoresSafeArea()
            ScrollView(.vertical) {
                Text("Friends")
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                LazyVStack {
                    ForEach(friendsCore, id: \.self) { friendCore in
                        HStack {
                            WebImage(url: URL(string: friendCore.photo ?? ""))
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .trailing) {
                                Text(friendCore.firstName ?? "")
                                    .font(.system(size: 18))
                                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                            }
                            Text(friendCore.lastName ?? "")
                                .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                            if (friendCore.status == 1) {
                                Text("Online").font(.system(size: 10)).foregroundStyle(.green)
                            } else {
                                Text("Offline").font(.system(size: 10)).foregroundStyle(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    }
                }
                .padding(10)
            }
            .padding(.top, 1)
        }
        .padding(.bottom, 15)
        .onAppear{
            friendsViewModel.getFriends(token: loginViewModel.token) {friends in
                self.friends = friends
                print(friends) //Friends information in console
            }
        }
    }
    func addNewFriend(photo: String, firstname: String, lastname: String, online: Int64) -> Void {
        let friendModel = Friend(photo: photo, firstname: firstname, lastname: lastname, online: online)
        CoreDataManager.shared.saveFriend(friendModel: friendModel)
    }
}

#Preview {
    FriendsView()
        .environmentObject(DataSource())
}

//struct FriendItemCore: View {
//    @EnvironmentObject var dataSource: DataSource
//    var name: String
//    var surname: String
//    var photo: String
//    var online: Int
//    
//    var body: some View{
//        HStack{
//            WebImage(url: URL(string: photo))
//                .resizable()
//                .frame(width: 50, height: 50)
//                .clipShape(Circle())
//            VStack(alignment: .leading) {
//                Text(name)
//                    .font(.system(size: 18))
//                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
//            }
//            Text(surname)
//                .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
//            if (online == 1) {
//                Text("Online").font(.system(size: 10)).foregroundStyle(.green)
//            } else {
//                Text("Offline").font(.system(size: 10)).foregroundStyle(.gray)
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(.bottom, 8)
//    }
//}
