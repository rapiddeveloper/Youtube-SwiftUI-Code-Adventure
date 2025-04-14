//
//  SVGImage.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/13/25.
//

import SwiftUI

struct SVGImage: View {
    let svg: String
    var width: CGFloat = 32.0
    var height: CGFloat = 32.0
    var color: Color = .black
    
    var body: some View {
        Image(svg)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .foregroundStyle(color)
    }
}
