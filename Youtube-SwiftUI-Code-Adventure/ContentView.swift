//
//  ContentView.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: TabViewEnum = .home
    var homeVM = HomeViewModel(videoRepository: PostRepository(service: .shared))
    
    @Environment(Router.self) var router

    
    var body: some View {
        
        @Bindable var tabRouter = router
        
        TabView(selection: $tabRouter.selectedTab) {
            ForEach(TabViewEnum.allCases) { tab in
            
                Tab(value: tab) {
                    tab
                }
            }

        }

       // .hidden()
        .safeAreaInset(edge: .bottom, content: {
            YouTubeTabView(selection: $tabRouter.selectedTab)
        })
        .ignoresSafeArea(edges: .all)
        .environment(homeVM)
         
    }
}

#Preview {
    ContentView()
        .environment(Router())
}
