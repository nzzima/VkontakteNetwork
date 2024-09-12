//
//  AppView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI

struct AppView: View {
    @State var selectTab = "Friends"
    let tabs = ["Friends","Groups","Photos","Profile"]
    
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
            HStack {
                ForEach(tabs, id: \.self) {tab in
                    Spacer()
                    TabBarItem(tab: tab, selected: $selectTab)
                    Spacer()
                }
            }
            .padding(.top, 15)
            .padding(.bottom, 15)
            .frame(maxWidth: .infinity)
            .background(Color("MainBG"))
        }
    }
}

struct TabBarItem: View {
    @State var tab: String
    @Binding var selected: String
    var body: some View {
        if tab == "Profile" {
            Button {
                withAnimation(.spring()) {
                    selected = tab
                }
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(selected == tab ? Color("SolidBG") : .white)
                    Image("Profile")
                        .resizable()
                        .frame(width: 28, height: 38)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }
            
        } else {
            ZStack {
                Button {
                    withAnimation(.spring()) {
                        selected = tab
                    }
                    
                } label: {
                    HStack {
                        Image(tab)
                            .resizable()
                            .frame(width: 20, height: 20)
                        if selected == tab {
                            Text(tab)
                                .font(.system(size: 14))
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 17)
            .opacity(selected == tab ? 1 : 0.7)
            .background(selected == tab ? .white : Color("MainBG"))
            .clipShape(Capsule())
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
