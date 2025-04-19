//
//  ErrorDetails.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/18/25.
//


//
//  ErrorDetails.swift
//  TravelBuddy
//
//  Created by Admin on 5/8/23.
//

import Foundation
import SwiftUI

@Observable
class ErrorDetails {
    
    private(set) var title: String = ""
    private(set) var message: String = ""
    private(set) var errorId: UUID?
    
    var isEmpty: Bool {
        title == "" ||  message == ""
    }
    
    func showError(_ title: String, _ message: String) {
        self.title = title
        self.message = message
        errorId = UUID()
    }
    
    func clear() {
        title = ""
        message = ""
        errorId = nil
    }
}

extension ErrorDetails {
    convenience init(title: String, message: String) {
        self.init()
        //self.update(title, message)
    }
}
