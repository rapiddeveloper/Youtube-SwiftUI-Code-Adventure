//
//  VideoRepository.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

struct PostRepository: PostRepositoryProtocol {
    
    var service: VideosAPIClient
    
    func getPosts() async  -> (PostsList?, RequestError?) {
         let result =  await service.getYouTubeVideos()
         
        switch result {
        case .success(let videosResponse):
            var postsList = PostsList()
            postsList.items = videosResponse.items.map({ video in
                Post(
                    id: video.id,
                     title: video.snippet.title,
                     description: video.snippet.description,
                     thumbnail: video.snippet.thumbnails,
                     mediaUrl: "",
                     mediaKind: .video,
                    channelTitle: video.snippet.channelTitle,
                     publishedAt: video.snippet.publishedAt
                )
            })
            postsList.nextPageToken = videosResponse.nextPageToken
            return (postsList, nil)
           // videos.map(\.toDomainModel)
        case .failure(let error):
            return (nil, error)
        }
     }
    
}


