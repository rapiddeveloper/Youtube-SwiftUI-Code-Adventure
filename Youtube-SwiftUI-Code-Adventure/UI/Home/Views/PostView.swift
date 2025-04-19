//
//  PostView.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    
    let post : Post
    @State private var thumbnail: Thumbnail
    //@Environment(ThemeManager.self) var themeManager

    
    init(_ post : Post){
        self.post = post
        self._thumbnail = State(initialValue: post.defaultThumbnail)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            WebImage(url: thumbnail.url) { image in
                   image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
               } placeholder: {
                       Rectangle().foregroundColor(.gray)
               }
               .transition(.fade(duration: 0.5)) // Fade Transition with duration
               .aspectRatio(576/325, contentMode: .fit)
               .frame(maxWidth: .infinity)
             Footer(post: post)

        }
              
             
     }
}

#Preview {
    PostView(PreviewData.samplePosts[1])
        .environment(ThemeManager())
}

struct Footer: View {
    
    let post: Post
    @Environment(ThemeManager.self) var themeManager
    
    var body: some View {
        HStack(alignment: .top, spacing: 0.0) {
            ProfilePhoto(avatarURL: post.channelProfileURL, profileRingColor: .clear, width: 50.0, height: 50.0)
            Spacer()
                .frame(width: 16.0)
            VStack(alignment: .leading, spacing: 4){
                Text(post.title)
                    .lineLimit(2)
                    .font(themeManager.theme.bodyLarge)
                    .foregroundStyle(themeManager.theme.onSurfaceColor)
                 HStack(spacing: 6) {
                    Text(post.channelTitle)
                         .lineLimit(1)
                    
                    Color(.gray)
                        .frame(width: 2, height: 2)
                    Text(post.displayedViewCount)
                    Color(.gray)
                        .frame(width: 2, height: 2)
                    Text(post.displayedPublishedAt)
                    
                }
                 .font(themeManager.theme.labelMedium)
                 .foregroundStyle(themeManager.theme.outlineColor)
                
            }
            Spacer()

            Image(systemName: "ellipsis")
                .foregroundStyle(themeManager.theme.onSurfaceColor)
                .rotationEffect(.degrees(90))
                .frame(width: 3, height: 23)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, 16)
        .padding(.trailing, 36)
        .padding(.top, 16)
        .padding(.bottom, 22)
        .background {
            themeManager.theme.surfaceColor
            //Color.red
        }
     }
}
