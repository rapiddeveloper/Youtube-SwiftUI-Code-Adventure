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
            
            // compute a channelProfile map
            let channelProfileMap = await channelProfileUrlMap(forVideos: videosResponse.items)
            var postsList = PostsList()
            postsList.items = videosResponse.items.map({ video in
                 return Post(
                    id: video.id,
                    title: video.snippet.title,
                    description: video.snippet.description,
                    thumbnail: video.snippet.thumbnails,
                    mediaUrl: "",
                    mediaKind: .video,
                    channelProfileURL: channelProfileMap[video.snippet.channelId],
                    channelTitle: video.snippet.channelTitle,
                    publishedAt: "" ,
                    displayedViewCount: formattingViewCountString(video.statistics.viewCount),
                    displayedPublishedAt: formattingTimeSinceDate(from: video.snippet.publishedAt)
                )
            })
            postsList.nextPageToken = videosResponse.nextPageToken
            return (postsList, nil)
            // videos.map(\.toDomainModel)
        case .failure(let error):
            return (nil, error)
        }
    }
    
    private func channelProfileUrlMap(forVideos videos: [YouTubeVideo]) async -> [String: URL] {
        // Step 1: Extract all channelIds
        let channelIds = videos.map { $0.snippet.channelId }
        
        // Step 2: Fetch channels using those channelIds
        let channelsResult = await service.getYouTubeChannels(ids: Array(Set(channelIds)))
        
        // Step 3: Create a map of channelId to channelProfileURL
        var channelProfileMap: [String: URL] = [:]
        if case .success(let channelResponse) = channelsResult {
            for item in channelResponse.items {
                let profileURL = item.snippet.thumbnails.default.url
                channelProfileMap[item.id] = URL(string: profileURL)
            }
        }
        
        return channelProfileMap
    }
    
    private func formattingViewCountString(_ input: String) -> String {
        guard let num = Double(input),
              num >= 0,
              num <= 1_000_000_000_000 else {
            return "0 views"
            //throw RequestError.invalidInput
        }
        
        let suffixes: [(value: Double, suffix: String)] = [
            (1_000_000_000_000, "T"),
            (1_000_000_000, "B"),
            (1_000_000, "M"),
            (1_000, "k")
        ]
        
        for (value, suffix) in suffixes {
            if num >= value {
                let formatted = (num / value).rounded(toPlaces: 1)
                let result = formatted.truncatingRemainder(dividingBy: 1) == 0 ?
                String(Int(formatted)) : String(formatted)
                return result + suffix + " views"
            }
        }
        
        return "\(String(num))k views"
    }
    
    
    
    private func formattingTimeSinceDate(from dateStr: String)  -> String {
        
        
        // First try with fractional seconds
        let formatterWithFractional = ISO8601DateFormatter()
        formatterWithFractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        // Fallback formatter (without fractional seconds)
        let fallbackFormatter = ISO8601DateFormatter()
        fallbackFormatter.formatOptions = [.withInternetDateTime]
        
        // Attempt to decode the date
        let date = formatterWithFractional.date(from: dateStr) ?? fallbackFormatter.date(from: dateStr)
        
        
        
        guard let inputDate = date else {
            return "N/A"
        }
        
        let now = Date()
        let diffSeconds = Int(now.timeIntervalSince(inputDate))
        let isFuture = diffSeconds < 0
        let absDiffSeconds = abs(diffSeconds)
        
        let diffMin = absDiffSeconds / 60
        let diffHr = diffMin / 60
        let diffDay = diffHr / 24
        let diffMonth = diffDay / 30
        let diffYear = diffDay / 365
        
        if isFuture {
            if diffDay == 0 { return "later today" }
            if diffDay == 1 { return "in 1 day" }
            return "in \(diffDay) days"
        }
        
        // Past
        if absDiffSeconds < 60 { return "just now" }
        if diffMin < 60 { return "\(diffMin) minute\(diffMin == 1 ? "" : "s") ago" }
        if diffHr < 24 { return "\(diffHr) hour\(diffHr == 1 ? "" : "s") ago" }
        if diffDay < 30 { return "\(diffDay) day\(diffDay == 1 ? "" : "s") ago" }
        if diffMonth < 12 { return "\(diffMonth) month\(diffMonth == 1 ? "" : "s") ago" }
        
        return "\(diffYear) year\(diffYear == 1 ? "" : "s") ago"
    }
    
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


