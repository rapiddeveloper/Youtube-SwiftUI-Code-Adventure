//
//  PreviewData.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

 

struct PreviewData {
    
    private static let thumbnail = Thumbnail(url: URL(string: "https://i.ytimg.com/vi/igDpFxg60qU/hqdefault.jpg")!, width: 320.0, height: 180.0)
    //let thumbnails:
    
    private static let thumbnails: Thumbnails = .init(default: thumbnail, medium: thumbnail, high: thumbnail, standard: thumbnail, maxres: thumbnail)
    
    
    static let samplePosts: [Post] = [
        .init(id: "1", title: "Florida vs. Houston - 2025 men's national championship extended highlights",
              description: "", thumbnail: PreviewData.thumbnails, mediaUrl: "", mediaKind: MediaKind.video, channelTitle: "Not Just Sports", publishedAt: ""),
        .init(id: "2", title: "HANDCUFFED TO MY BEST-FRIEND FOR 24 HOURS!",
              description: "", thumbnail: PreviewData.thumbnails, mediaUrl: "", mediaKind: MediaKind.video, channelTitle: "Not Just Movies", publishedAt: ""),
        .init(id: "3", title: "Lagos vs. Houston - 2025 men's national championship extended highlights",
              description: "", thumbnail: PreviewData.thumbnails, mediaUrl: "", mediaKind: MediaKind.video, channelTitle: "Not Just Games", publishedAt: "")
    ]
}
