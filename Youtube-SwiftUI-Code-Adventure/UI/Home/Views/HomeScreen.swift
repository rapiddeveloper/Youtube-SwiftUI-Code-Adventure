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
 
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            @Bindable var homeVMBinding = homeViewModel
            
                LazyVStack(spacing: 0) {
                    ForEach(homeVMBinding.posts, id: \.id) { post in
                        PostView(post)
                            .onScrollVisibilityChange(threshold: 0.9) { isVisible in
                                if isVisible && isPenultimatePost(post) {
                                    Task {
                                        await homeViewModel.loadVideos()
                                    }
                                }
                            }
                    }
                    
                    if homeVMBinding.isLoadingPosts == .loading && homeVMBinding.hasPosts {
                        ProgressView()
                    } else if homeVMBinding.isLoadingPosts == .loading && !homeVMBinding.hasPosts {
                        HomeScreenPlaceHolder()
                        
                    } else if homeVMBinding.isLoadingPosts == .idle && !homeVMBinding.hasPosts {
                        EmptyHomeScreen()
                        
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

extension  HomeScreen {
    func isPenultimatePost(_ post: Post) -> Bool {
        homeViewModel.posts.lastIndex(where: { $0.id == post.id }) == homeViewModel.posts.count - 2
    }
}


#Preview {
    HomeScreen()
        .environment(HomeViewModel(videoRepository: .init(service: .shared)))
        .environment(ErrorDetails())
        .environment(ThemeManager())
}
 

struct EmptyHomeScreen: View {
    var body: some View {
        VStack {
            Text("No Posts Found")
        }
        .containerRelativeFrame([.horizontal, .vertical], { length, axis in
            length
        })
    }
}
