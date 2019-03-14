//
//  ApiConfiguaration.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 Lekan. All rights reserved.
//

import Foundation
import Alamofire

/**
 Used for implementing the basic method needed by alamofire UrlRequestConvertible
 */
protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

