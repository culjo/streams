//
//  ApiConfiguaration.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 Lekan. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

