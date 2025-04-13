//
//  YoutubeVideosResponse.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

import Foundation

struct YouTubeVideosResponse: Codable {
    let kind: String
    let etag: String
    let items: [YouTubeVideo]
    let nextPageToken: String
    let pageInfo: PageInfo
}

struct YouTubeVideo: Codable, Identifiable {
    let kind: String
    let etag: String
    let id: String
    let snippet: Snippet
    let statistics: Statistics
}

struct Snippet: Codable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let tags: [String]?
    let categoryId: String
    let liveBroadcastContent: String
    let localized: Localized
    let defaultAudioLanguage: String?
}

struct Thumbnails: Codable {
    let `default`: Thumbnail
    let medium: Thumbnail
    let high: Thumbnail
    let standard: Thumbnail
    let maxres: Thumbnail
}

struct Thumbnail: Codable {
    let url: String
    let width: CGFloat
    let height: CGFloat
}

struct Localized: Codable {
    let title: String
    let description: String
}

struct Statistics: Codable {
    let viewCount: String
    let likeCount: String
    let favoriteCount: String
    let commentCount: String?
}

struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}
