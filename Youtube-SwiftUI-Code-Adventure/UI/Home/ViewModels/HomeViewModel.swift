//
//  HomeViewModel.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor
class HomeViewModel {
    
    private var videoRepository: PostRepository
    
    private(set) var postsList: PostsList = PostsList()
    
    var posts : [Post] {
        postsList.items
    }
    
    
    init(videoRepository: PostRepository) {
        self.videoRepository = videoRepository
    }
    
    func loadVideos() async {
        let (fetchedVideos, getVideosError) = await videoRepository.getPosts()
        
       if let error = getVideosError {
            print("Error fetching videos: \(error)")
            return
        }
        
        guard let fetchedVideos = fetchedVideos else {
            print("Failed to fetch videos.")
            return
        }
        
        self.postsList = fetchedVideos
        print("Loaded \(postsList.items.count) videos.")
    }
    
}
