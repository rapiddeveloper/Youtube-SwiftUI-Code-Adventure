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
    private(set) var isLoadingPosts: RequestStatus = .idle
    
    var posts : [Post] {
        postsList.items
    }
    
    var hasPosts: Bool {
        !posts.isEmpty
    }
    
    
    init(videoRepository: PostRepository) {
        self.videoRepository = videoRepository
        Task {
            await  loadVideos()
         }
    }
    
    func loadVideos() async {
        
 
        
        if isLoadingPosts != .idle || (!posts.isEmpty && !videoRepository.canLoadmorePosts) {
            return
        }
        
        isLoadingPosts = .loading
        let (fetchedVideos, getVideosError) = await videoRepository.getPosts()
        
       if let error = getVideosError {
            isLoadingPosts = .failure(error)
            print("Error fetching videos: \(error)")
            return
        }
        
        guard let fetchedVideos = fetchedVideos else {
            print("Failed to fetch videos.")
            isLoadingPosts = .failure(.unexpected())
            return
        }
        
        isLoadingPosts = .idle
        self.postsList.items.append(contentsOf: fetchedVideos.items)
     }
    
}
