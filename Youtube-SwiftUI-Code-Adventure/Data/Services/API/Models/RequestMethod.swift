//
//  RequestMethod.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//


//  RequestMethod.swift
//  Prettycharm
//
//  Created by Admin on 9/23/22.
//

import Foundation

enum RequestMethod: String  {
    case delete = "DELETE"
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
}

enum RequestStatus: Equatable {
    case idle
    case loading
    case success
    case failure(RequestError)
}
