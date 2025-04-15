//
//  Utitlities.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/14/25.
//

import UIKit

public func printSystemFonts() {
    // Use this identifier to filter out the system fonts in the logs.
    let identifier: String = "[SYSTEM FONTS]"
    // Here's the functionality that prints all the system fonts.
    for family in UIFont.familyNames as [String] {
        debugPrint("\(identifier) FONT FAMILY :  \(family)")
        for name in UIFont.fontNames(forFamilyName: family) {
            debugPrint("\(identifier) FONT NAME :  \(name)")
        }
    }
}
