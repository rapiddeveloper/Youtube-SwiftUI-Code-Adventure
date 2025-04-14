//
//  TabViewEnum.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/13/25.
//

import SwiftUI

enum TabViewEnum: String, CaseIterable, Identifiable, View {
    
    case home
    case shorts
    case create
    case subscriptions
    case accout
    
    var id: Self {
        self
    }
    
    var body: some View {
        switch self {
        case .home:
            HomeScreen()
        case .shorts:
            Text("Shorts Screen")
        case .create:
            Text("Create Screen")
        case .subscriptions:
            Text("Subscriptions")
        case .accout:
            Text("Account")
        }
         
    }
    
    var tabItem: TabItem {
        var name = self.rawValue.capitalized
        switch self {
        case .home:
            return .init(name: name, image: "Home")
        case .shorts:
            return  .init(name: name, image: "Shorts")
        case .create:
            return .init(name: name, image: "Create")
        case .subscriptions:
            return .init(name: name, image: "Subscriptions")
        case .accout:
               return .init(name: name, image: "Home")
        }
    }
    
    
}
