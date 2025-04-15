//
//  YouTubeTabView.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/14/25.
//

import SwiftUI

struct YouTubeTabView: View {
    @Binding var selection: TabViewEnum
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabViewEnum.allCases) { tabView in
                Button {
                    selection = tabView
                } label: {
                    VStack {
                        if tabView == .accout {
                            Image(systemName: "person.circle")
                                .font(.title3)
                         } else {
                             SVGImage(
                                svg: tabView.tabItem.image,
                                width: tabView == .create ? 23: 23 * 0.7,
                                height: tabView == .create ? 26: 26 * 0.7
                             )
                        }
                        if tabView != .create {
                            Text(tabView.tabItem.name)
                                .font(.system(size: 9, weight: .regular))
                        } else {
                           // Text("create")
                            //    .hidden()
                        }
                    }
                    .containerRelativeFrame([.horizontal], count: TabViewEnum.allCases.count, spacing: 0 )
                    .padding(.vertical, 6)
                    
                   
                }
                .tint(selection == tabView ? .blue : .gray)
                

            }
           
        }
        .padding(.bottom, 10.0)
        .frame(maxWidth: .infinity)
        .background(.white, in: Rectangle())
      }
}

#Preview {
    @Previewable @State var selectedTab: TabViewEnum = .home
    YouTubeTabView(selection: $selectedTab)
}
