//
//  Extentions.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/18/25.
//

import SwiftUI

extension View {
    func errorAlert(errorDetails: ErrorDetails) -> some View {
         self
            .modifier(ErrorAlert(errorDetails: errorDetails))
    }
    
    /// Allows a view to show progress of a task that loads initial data for a view. It allows the user to retry the task.
    /// - Parameters:
    ///   - status: status of the request/task
    ///   - retryAction: action to perform when task is retried
    /*
    func progressable(status: RequestStatus, showText: Bool = true, retryAction: @escaping ()->Void) -> some View {
        self
            .modifier(Progressable(status: status, showText: showText, refreshAction: retryAction))
    }*/
    
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
