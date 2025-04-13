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

struct ProfilePhoto: View {
    
    let avatarURL: String
    var profileRingColor: Color = .white
    var width: CGFloat = 66
    var height: CGFloat = 66
    
    var body: some View {
        AsyncImage(url: URL(string: avatarURL)) { image in
            image
                .resizable()
                .frame(width: width, height: height)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(profileRingColor, lineWidth: 2)
                )
        } placeholder: {
            ProgressView()
                .controlSize(.small)
        }

    }
}

#Preview {
    ProfilePhoto(
        avatarURL: "https://res.cloudinary.com/adminixtrator/image/upload/v1742196112/vmodel/sq-2.png", width: 66, height: 66)
}
