//
//  AppView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var dataSource: DataSource
    @State var selectTab = "Friends"
    let tabs = ["Friends", "Groups", "Photos", "Profile"]
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectTab) {
                    FriendsView()
                        .tag("Friends")
                    GroupsView()
                        .tag("Groups")
                    PhotosView()
                        .tag("Photos")
                    ProfileView()
                        .tag("Profile")
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack {
                ForEach(tabs, id: \.self) {tabItem in
                    Spacer()
                    TabBarItem(tabItem: tabItem, selected: $selectTab)
                    Spacer()
                }
            }
            .padding(.top, 15)
            .padding(.bottom, 15)
            .frame(maxWidth: .infinity)
            .background(Color(dataSource.selectedTheme.secondaryColor))
        }
    }
}

struct TabBarItem: View {
    @EnvironmentObject var dataSource: DataSource
    @State var tabItem: String
    @Binding var selected: String
    var body: some View {
        if tabItem == "Profile" {
            Button {
                withAnimation {selected = tabItem}
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(selected == tabItem ? Color("SolidBG") : .white)
                    Image("Profile")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }
        } else {
            ZStack {
                Button {
                    withAnimation(.spring()) {
                        selected = tabItem
                    }
                } label: {
                    HStack {
                        Image(tabItem)
                            .resizable()
                            .frame(width: 20, height: 20)
                        if selected == tabItem {
                            Text(tabItem)
                                .font(.system(size: 14))
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 17)
            .opacity(selected == tabItem ? 1 : 0.7)
            .background(selected == tabItem ? .white : Color(dataSource.selectedTheme.secondaryColor))
            .clipShape(Capsule())
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(DataSource())
    }
}
