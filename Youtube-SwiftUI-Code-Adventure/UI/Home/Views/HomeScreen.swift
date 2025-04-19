//
//  HomeScreen.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(HomeViewModel.self) var homeViewModel
    @Environment(ErrorDetails.self) var errorDetails
    //@Environment(ThemeManager.self) var themeManager

    
    var body: some View {
        ScrollView(showsIndicators: false) {
            @Bindable var homeVMBinding = homeViewModel
            LazyVStack(spacing: 0) {
                ForEach(homeVMBinding.posts, id: \.id) { post in
                    PostView(post)
                 }
            }
            .overlay(alignment: .center) {
                if homeVMBinding.isLoadingPosts == .loading {
                    VStack {
                        ProgressView()
                    }
                }
            }
            .onChange(of: homeVMBinding.isLoadingPosts) { oldValue, newValue in
                print("errored")
                if case .failure(let error) = homeViewModel.isLoadingPosts {
                    errorDetails.showError("Error", error.localizedDescription)
                }
            }
            
        }
        
    }
}

#Preview {
    HomeScreen()
        .environment(HomeViewModel(videoRepository: .init(service: .shared)))
}
