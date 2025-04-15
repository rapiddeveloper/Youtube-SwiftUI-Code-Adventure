//
//  Post.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

enum MediaKind: String {
    case video
    case photo
    case article
}

struct PostsList {
     var nextPageToken: String = ""
     var items: [Post] = []
}

 
struct Post: Identifiable {
    var id: String
    var title: String
    var description: String
    var thumbnail: Thumbnails
    var mediaUrl: String
    var mediaKind: MediaKind
    var viewCount: Int = 1000
    var channelProfileURL: String = "https://res.cloudinary.com/adminixtrator/image/upload/v1742196112/vmodel/sq-2.png"
    var channelTitle: String 
    var publishedAt: String
    
    var defaultThumbnail: Thumbnail {
        thumbnail.medium
    }
    
    var displayedViewCount: String = "0 views"
    var displayedPublishedAt: String = "N/A"

    
//    var displayedViewCount: String {
//        "\(String(viewCount/1000))k views"
//    }
    
    var displayedChannelProfileURL: URL {
        URL(string: channelProfileURL)!
    }
    
//    var displayedPublishedAt: String {
//        "1 hour ago"
//    }
}
