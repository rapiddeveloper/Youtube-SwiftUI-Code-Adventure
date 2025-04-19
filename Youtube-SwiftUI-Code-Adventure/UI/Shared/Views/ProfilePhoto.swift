//
//  ProfilePhoto.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//


//
//  ProfilePhoto.swift
//  TikTok-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/4/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfilePhoto: View {
    
    let avatarURL: URL?
    var profileRingColor: Color = .white
    var width: CGFloat = 66
    var height: CGFloat = 66
    
    var body: some View {
        WebImage(url: avatarURL) { image in
               image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
           } placeholder: {
               Circle().foregroundColor(.gray)
           }
           .transition(.fade(duration: 0.5)) // Fade Transition with duration
           .aspectRatio(1/1, contentMode: .fit)
           .frame(width: width, height: height)
           .clipShape(Circle())
           .overlay(
            Circle()
                .stroke(profileRingColor, lineWidth: 2)
           )
//        AsyncCachedImage(url: URL(string: avatarURL)) { image in
//            image
//                .resizable()
//                .aspectRatio(1/1, contentMode: .fit)
//                .frame(width: width, height: height)
//                .clipShape(Circle())
//                .overlay(
//                    Circle()
//                        .stroke(profileRingColor, lineWidth: 2)
//                )
//        } placeholder: {
//            ProgressView()
//                .controlSize(.small)
//        }
 
    }
}

#Preview {
    var url = URL(string:  "https://res.cloudinary.com/adminixtrator/image/upload/v1742196112/vmodel/sq-2.png")
   return ProfilePhoto(
        avatarURL: url, width: 66, height: 66)
}
