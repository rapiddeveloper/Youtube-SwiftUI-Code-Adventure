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
                        .toolbarVisibility(.hidden, for: .tabBar)

                } label: {
                    if tab == .accout {
                        Image(systemName: "person.circle")
                            .font(.title3)
                     } else {
                        SVGImage(svg: tab.tabItem.image, width: 23, height: 26)
                    }
                    if tab != .create {
                        Text(tab.tabItem.name)
                    }
                }

            }

        }
        .safeAreaInset(edge: .bottom, content: {
            YouTubeTabView(selection: $tabRouter.selectedTab)
        })
        .ignoresSafeArea(edges: .all)
        .environment(homeVM)
        .onAppear {
            Task {
                await  homeVM.loadVideos()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(Router())
}
