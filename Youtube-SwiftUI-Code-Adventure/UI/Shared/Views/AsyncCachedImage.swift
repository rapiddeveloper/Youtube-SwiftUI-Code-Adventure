//
//  AsyncCachedImage.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/16/25.
//


//
//  AsyncCacheImage.swift
//  VModel
//
//  Created by Orisajobi Akinbola on 3/2/25.
//

import Foundation
import SwiftUI

@MainActor
struct AsyncCachedImage<ImageView: View, PlaceholderView: View>: View {
    // Input dependencies
    var url: URL?
    @ViewBuilder var content: (Image) -> ImageView
    @ViewBuilder var placeholder: () -> PlaceholderView
    
    // Downloaded image
    @State var image: UIImage? = nil
    @State var fetchImgTaskId: UUID?
    
    init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> ImageView,
        @ViewBuilder placeholder: @escaping () -> PlaceholderView
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
        
    }
    
    var body: some View {
        VStack {
            if let uiImage = image {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .onAppear {
                       // fetchImgTaskId = UUID()
                        
                         Task {
                         image = await downloadPhoto()
                         }
                    }
            }
        }
//        .task(id: fetchImgTaskId) {
//            guard fetchImgTaskId != nil else { return }
//            image = await downloadPhoto()
//        }
//        .onChange(of: url) { oldValue, newValue in
//           
//            fetchImgTaskId = UUID()
//        }
    }
    
    
      
    
    // Downloads if the image is not cached already
    // Otherwise returns from the cache
    private func downloadPhoto() async -> UIImage? {
        do {
            guard let url else { return nil }
            
            // Check if the image is cached already
            if let cachedResponse = URLCache.shared.cachedResponse(for: .init(url: url)) {
                
                return UIImage(data: cachedResponse.data)
            } else {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                
                // Save returned image data into the cache
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: .init(url: url))
                
                guard let image = UIImage(data: data) else {
                    print("failed to make image")
                    return nil
                }
                
                return image
            }
        } catch {
            print("Error downloading: \(error)")
            return nil
        }
    }
}
