//
//  ThemeManager.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/14/25.
//

import SwiftUI
import Foundation

@Observable
class ThemeManager {
   
    let main: ThemeProtocol = Main()
    
    private(set) var theme: ThemeProtocol
    
    init() {
        self.theme = main
    }
    
}

extension ThemeManager {
    
}
