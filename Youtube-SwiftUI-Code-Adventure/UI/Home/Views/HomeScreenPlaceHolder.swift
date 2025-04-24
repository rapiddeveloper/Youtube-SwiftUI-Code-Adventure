//
//  HomeScreenPlaceHolder.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/24/25.
//

import SwiftUI

struct HomeScreenPlaceHolder: View {
    var body: some View {
        VStack {
            ProgressView()
        }
        .containerRelativeFrame([.horizontal, .vertical], { length, axis in
            length
        })
    }
}
