//
//  VideosAPIClient.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

struct VideosAPIClient: HTTPClient {
    
    static let shared = VideosAPIClient()
    let baseUrl = URL(string: "https://www.googleapis.com")!
    var apiKey = "" // insert your api key
    
    init() {
        
        do {
            guard let url = Bundle.main.url(forResource: "config", withExtension: "plist") else {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            let data = try Data(contentsOf: url)
            let config = try PropertyListDecoder().decode(Config.self, from: data)
              apiKey = config.APIKey
             print("API Key: \(config.APIKey)")
        } catch {
            debugPrint(error.localizedDescription)
            //fatalError("Error reading plist")
        }
       
    }
    
    func getYouTubeVideos() async -> Result<YouTubeVideosResponse, RequestError> {
        guard var videosURL = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&maxResults=10") else {
            return .failure(.invalidURL())
        }
        
        videosURL.append(queryItems: [.init(name: "key", value: apiKey)])
        var request = URLRequest(url: videosURL)
        request.httpMethod = .GET
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        return await sendRequest(request, responseModel: YouTubeVideosResponse.self)
         
    }
    
    func getYouTubeChannels(ids: [String]) async -> Result<YouTubeChannelsResponse, RequestError> {
        
        guard !ids.isEmpty else { return .failure(.unexpected()) }
        
        let channelIdsStr =  ids.joined(separator: ",")

        guard var channelsURL = URL(string: "\(baseUrl)/youtube/v3/channels?part=snippet&id=\(channelIdsStr)") else {
            return .failure(.invalidURL())
        }
        
        
        channelsURL.append(queryItems: [.init(name: "key", value: apiKey)])
        var request = URLRequest(url: channelsURL)
        request.httpMethod = .GET
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        return await sendRequest(request, responseModel: YouTubeChannelsResponse.self)
         
    }
}
