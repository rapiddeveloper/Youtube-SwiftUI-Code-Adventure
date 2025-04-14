//
//  RequestError.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

 import Foundation

enum RequestError: Equatable, LocalizedError, Error {
    
    case addressUnreachable(URL)
    case invalidURL(String? = nil)
    case notFound
    case badRequest(String?)
    case server
    case unauthorized
    case decode
    case unexpected(String? = nil)
    case noResponse(String?)
    case unknown(String?)
    case accountNotExist(name: String, email: String)
    case invalidInput
    
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let msg), .noResponse(let msg), .unknown(let msg), .unexpected(let msg):
        
            guard let errMsg = msg else { return "Unexpected Error"}
            return errMsg
        case .addressUnreachable(_):
            return "No Internet"
        default:
            return "Unexpected Error"
        }
    }
    
    var recoverySuggestion: String? {
        
            let errorMsg = "An error occured trying to fulfil your request. Please try again later or contact support"
        
            switch self {
            case .invalidURL(let msg), .noResponse(let msg), .unknown(let msg), .unexpected(let msg):
            
                guard let customErrorMsg = msg else { return errorMsg}
                return customErrorMsg
            case .addressUnreachable(_):
                return "TerraTrek seems to be offline. Connect to internet"
            default:
                return "An error occured trying to fulfil your request. Please try again later or contact support"
            }
        
    }
}
