//
//  MovieInfo.swift
//  Streams
//
//  Created by MAC on 3/14/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import Foundation

struct MovieInfo {
    
    init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }
    
    let key, value: String
}
