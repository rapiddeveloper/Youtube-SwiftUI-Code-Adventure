//
//  VideosAPIClient.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

class VideosAPIClient: HTTPClient {
    
    static let shared = VideosAPIClient()
    let baseUrl = URL(string: "https://www.googleapis.com")!
    private var apiKey: String!
    private var nextVideosPageToken: String?
    
    var canGetMoreVideos: Bool {
        return nextVideosPageToken != nil && !nextVideosPageToken!.isEmpty
    }
    
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
        if let nextPageToken = nextVideosPageToken {
            videosURL.append(queryItems: [.init(name: "pageToken", value: nextPageToken)])
        }
        var request = URLRequest(url: videosURL)
        request.httpMethod = .GET
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let result = await sendRequest(request, responseModel: YouTubeVideosResponse.self)
        if let nextPageToken = try? result.get().nextPageToken {
            self.nextVideosPageToken = nextPageToken
        }
        return result
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
