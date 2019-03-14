//
//  UrlConstants.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

/// App central resource for storing the api url and string constants
struct UrlConstants {
    // API's base URL
    static let baseUrl = "http://www.omdbapi.com/"
    
    // Note: This can be stored somewhere else
    static let apiKey = "1fe468b0"
    
    // Common HTTP Headers
    enum HTTPHeaderField: String {
        case authenitication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        
    }
    
    // the content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
    
}
