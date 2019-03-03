//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {

    var season1: Season!
    var season2 : Season!
    var episode1: Episode!
    var epidode2: Episode!
    var episode1Date: Date!
    var episode2Date: Date!
    
    override func setUp() {
        
        // Strings to Date format
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        episode1Date = formatter.date(from: "01/04/2012")
        episode2Date = formatter.date(from: "08/04/2012")
        season1 = Season(name: "Season1", releaseDateSeason: episode1Date )
        season2 = Season(name: "Season2", releaseDateSeason: episode2Date)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season1)
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertNotNil(season1.description)
    }
    
    func testSeasonEquality() {
        XCTAssertEqual(season1, season1)
        XCTAssertNotEqual(season1, season2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season1.hashValue)
        XCTAssertNotNil(season2.hashValue)
    }
    func testSeasonComparison() {
        XCTAssertLessThan(season1, season2)
        
    }
    

}
