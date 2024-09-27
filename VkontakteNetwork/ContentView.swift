//
//  ContentView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var dataSource: DataSource
    var body: some View {
        LoginView()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
