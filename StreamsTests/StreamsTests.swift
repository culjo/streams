//
//  StreamsTests.swift
//  StreamsTests
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import XCTest
@testable import Streams

class StreamsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: Movie Model Class Tests
    
    // Confirm that the model init correctely and return an object when passed
    func testMovie() {
        let movie = Movie.init(title: "Title", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", ratings: [], metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", dvd: "", boxOffice: "", production: "", website: "", response: "")
        XCTAssertNotNil(movie)
    }
    
    // Confirm that a title cannot be empty
    func testMovieTitleNotEmpty() {
        // In a standard we will put a check in the movie class to reject empty title from being created as a movie
        let movie = Movie.init(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", ratings: [], metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", dvd: "", boxOffice: "", production: "", website: "", response: "")
        
        XCTAssertNotEqual(movie.title, "")
        
    }

}
