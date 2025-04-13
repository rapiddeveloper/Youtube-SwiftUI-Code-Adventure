//
//  VideoRepositoryProtocol.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/9/25.
//

import Foundation

protocol PostRepositoryProtocol {
    
    func getPosts() async  -> (PostsList?, RequestError?)
}
