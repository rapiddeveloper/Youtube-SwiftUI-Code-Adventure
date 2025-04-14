//
//  YoutubeChannelsResponse.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/14/25.
//

 

import Foundation

// MARK: - YoutubeChannelsResponse
struct YouTubeChannelsResponse: Codable {
    let kind, etag: String
    let pageInfo: PageInfo
    let items: [Channel]
}

// MARK: - Item
struct Channel: Codable {
    let kind, etag, id: String
    let snippet: ChannelSnippet
}

// MARK: - Snippet
struct ChannelSnippet: Codable {
    let title, description, customUrl: String
    let publishedAt: String
    let thumbnails: ChannelThumbnails
    let defaultLanguage: String?
    let localized: ChannelLocalized

//    enum CodingKeys: String, CodingKey {
//        case title, description
//        case customURL = "customUrl"
//        case publishedAt, thumbnails, defaultLanguage, localized
//    }
}

// MARK: - Localized
struct ChannelLocalized: Codable {
    let title, description: String
}

// MARK: - Thumbnails
struct ChannelThumbnails: Codable {
    let `default`, medium, high: ThumbnailsDefault

//    enum CodingKeys: String, CodingKey {
//        case thumbnailsDefault = "default"
//        case medium, high
//    }
}

// MARK: - Default
struct ThumbnailsDefault: Codable {
    let url: String
    let width, height: Int
}

// MARK: - PageInfo
//struct PageInfo: Codable {
//    let totalResults, resultsPerPage: Int
//}
