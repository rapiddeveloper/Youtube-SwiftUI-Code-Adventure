//
//  HomeScreen.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(HomeViewModel.self) var homeViewModel
    //@Environment(ThemeManager.self) var themeManager

    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(homeViewModel.posts, id: \.id) { post in
                    PostView(post)
                      //  .environment(themeManager)
                }
            }
        }
        
    }
}

#Preview {
    HomeScreen()
        .environment(HomeViewModel(videoRepository: .init(service: .shared)))
}
