//
//  Youtube_SwiftUI_Code_AdventureApp.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import SwiftUI

@main
struct Youtube_SwiftUI_Code_AdventureApp: App {
    
    var homeVM = HomeViewModel(videoRepository: PostRepository(service: .shared))
    
    var body: some Scene {
        WindowGroup {
           // ContentView()
            HomeScreen()
                .environment(homeVM)
                .onAppear {
                    Task {
                        await  homeVM.loadVideos()
                    }
                }
        }
    }
}
