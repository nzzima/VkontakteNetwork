//
//  PhotosView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 10.09.2024.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct PhotosView: View {
    @EnvironmentObject var dataSource: DataSource
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var photosViewModel = PhotosViewModel()
    @State var photos = [Photo]()
    var body: some View {
        ZStack {
            Color(dataSource.selectedTheme.primaryColor)
                .ignoresSafeArea()
            ScrollView(.vertical) {
                Text("Photos")
                    .foregroundStyle(Color(dataSource.selectedTheme.labelColor))
                LazyVStack {
                    ForEach(photos, id: \.self) { photo in
                        PhotoItem(surl: photo.sizes[0].urlLink)
                    }
                }
                .padding(10)
            }
            .padding(.top, 1)
        }
        .padding(.bottom, 15)
        .onAppear {
            photosViewModel.getPhotos(token: loginViewModel.token) {photos in
                self.photos = photos
            }
        }
    }
}

#Preview {
    PhotosView()
        .environmentObject(DataSource())
}

struct PhotoItem: View {
    var surl: String
    var body: some View {
        HStack {
            WebImage(url: URL(string: surl))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}
