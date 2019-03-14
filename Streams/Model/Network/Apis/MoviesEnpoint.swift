//
//  MoviesEnpoint.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesEndpoint: ApiConfiguration {
    
    case fetchMovie(title: String, year: String)
    case fetchMovieById(omdbId: String)
    case searchMovies(searchString: String)
    
    var method: HTTPMethod {
        switch self {
        case .fetchMovie, .fetchMovieById, .searchMovies:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchMovie:
            return ""
        case .fetchMovieById:
            return ""
        case .searchMovies:
            return ""
            
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchMovie(let title, let year):
            return ["t": title, "y": year, "apikey": UrlConstants.apiKey]
        case .fetchMovieById(let omdbId):
            return ["i": omdbId, "apikey": UrlConstants.apiKey]
        case .searchMovies(let searchString):
            return ["s": searchString, "apikey": UrlConstants.apiKey]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try UrlConstants.baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        // Set HTTP Method to the request based on the requested api
        request.httpMethod = method.rawValue
        
        // Set Common Request Headers
        request.setValue(UrlConstants.ContentType.json.rawValue, forHTTPHeaderField: UrlConstants.HTTPHeaderField.acceptType.rawValue)
        request.setValue(UrlConstants.ContentType.json.rawValue, forHTTPHeaderField: UrlConstants.HTTPHeaderField.contentType.rawValue)
        
        
        
        
        // We have to perform parameter enconding base on the http method type
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(request, with: parameters)
    }
    
    
}
