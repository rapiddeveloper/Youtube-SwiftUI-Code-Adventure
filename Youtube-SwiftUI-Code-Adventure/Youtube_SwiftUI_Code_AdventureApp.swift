//
//  Youtube_SwiftUI_Code_AdventureApp.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import SwiftUI

@main
struct Youtube_SwiftUI_Code_AdventureApp: App {
    
    var router = Router()
    var themeManager: ThemeManager = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(router)
                .environment(themeManager)
        }
    }
}
