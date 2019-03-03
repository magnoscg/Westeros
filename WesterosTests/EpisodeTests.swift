//
//  EpisodeTest.swift
//  WesterosTests
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTest: XCTestCase {
    
    var episode1: Episode!
    var episode2: Episode!
    var episode1ReleaseDate: Date!
    var episode2ReleaseDate: Date!
    var season: Season!
    
    override func setUp() {

        // Strings to Date format
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        episode1ReleaseDate = formatter.date(from: "01/04/2012")
        episode2ReleaseDate = formatter.date(from: "08/04/2012")
        
        episode1 = Episode(title: "El norte no olvida", releaseDate: episode1ReleaseDate, season: season)
        episode2 = Episode(title: "Las tierras de la noche", releaseDate: episode2ReleaseDate, season: season)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode1)
        XCTAssertNotNil(episode2)
    }
    func testEpisodeCustomStringConvertible() {
        XCTAssertNotNil(episode1.description)
    }
    func testEpisodeEquality() {
        XCTAssertEqual(episode1, episode1)
        XCTAssertNotEqual(episode1, episode2)
    }
    func testEpisodeHashable() {
        XCTAssertNotNil(episode1.hashValue)
    }
    func testEpisodeComparison() {
        XCTAssertLessThan(episode1, episode2)
    }


}
