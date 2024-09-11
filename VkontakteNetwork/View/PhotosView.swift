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
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var photosViewModel = PhotosViewModel()
    @State var photos = [Photo]()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                Text("Photos")
                LazyVStack {
                    ForEach(photos, id: \.self) { photo in
                        PhotoItem(surl: photo.sizes[0].url)
                    }
                }
                .padding(10)
            }
        }
        .padding(.top, 50)
        .onAppear{
            photosViewModel.getPhotos(token: loginViewModel.token) {photos in
                self.photos = photos
                print(photos) //Photos information in console
            }
        }
    }
}

#Preview {
    PhotosView()
}

struct PhotoItem: View {
    var surl: String
    
    var body: some View{
        HStack{
            WebImage(url: URL(string: surl))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}
