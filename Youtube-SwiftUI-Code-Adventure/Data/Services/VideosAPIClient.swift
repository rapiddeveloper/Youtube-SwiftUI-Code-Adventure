//
//  VideosAPIClient.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

struct VideosAPIClient: HTTPClient {
    
    static let shared = VideosAPIClient()
    
    func getYouTubeVideos() async -> Result<YouTubeVideosResponse, RequestError> {
        guard var videosURL = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=10") else {
            return .failure(.invalidURL())
        }
        
        videosURL.append(queryItems: [.init(name: "key", value: "AIzaSyB-8s0cTHI5xXxD-WjqpwRJm2NpBsmJb_Q")])
        var request = URLRequest(url: videosURL)
        request.httpMethod = .GET
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.setValue("key AIzaSyB-8s0cTHI5xXxD-WjqpwRJm2NpBsmJb_Q", forHTTPHeaderField: "Authorization")
        
        return await sendRequest(request, responseModel: YouTubeVideosResponse.self)
         
    }
}
