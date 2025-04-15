//
//  ThemeProtocol.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/14/25.
//

import SwiftUI

/**
 Protocol for themes
 */
protocol ThemeProtocol {
    var displaLarge: Font { get }
    var headlineMedium: Font { get }
    var titleMedium: Font { get }
    var bodyLarge: Font { get }
    var labelMedium: Font { get }
 
    var primaryColor: Color { get }
    var onPrimaryColor: Color { get }
    var backgroundColor: Color { get }
    var onBackgroundColor: Color { get }
    var surfaceColor: Color { get }
    var onSurfaceColor: Color { get }
    var surfaceVariantColor: Color { get }
    var onSurfaceVariantColor: Color { get }
    var outlineColor: Color { get }
    var errorColor: Color { get }
    var onErrorColor: Color { get }


}
/**
 Main Theme
 */
struct Main: ThemeProtocol {
    var displaLarge: Font = .custom("Roboto-Regular", size: 57.0)
    var headlineMedium: Font = .custom("Roboto-Medium", size: 28.0)
    var titleMedium: Font = .custom("Roboto-Medium", size: 16.0)
    var bodyLarge: Font = .custom("Roboto-Regular", size: 16.0)
    var labelMedium: Font = .custom("Roboto-Medium", size: 12.0)
    
    var primaryColor: Color { return .ytPrimary }
    var onPrimaryColor: Color { return .onPrimary }
    var backgroundColor: Color { return .ytBackground }
    var onBackgroundColor: Color { return .onBackground }
    var surfaceColor: Color { .ytSurface }
    var onSurfaceColor: Color {  .onSurface }
    var surfaceVariantColor: Color {  .surfaceVariant }
    var onSurfaceVariantColor: Color {  .onSurfaceVariant }
    var outlineColor: Color { .ytOutline }
    var errorColor: Color { .ytError }
    var onErrorColor: Color { .onError }

 
}
