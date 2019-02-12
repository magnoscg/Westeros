//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Oscar canton on 11/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import XCTest
@testable import Westeros
class RepositoryTests: XCTestCase {
    var houses: [House]!
    
    override func setUp() {
        houses = Repository.local.houses
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
        
    }
    
    func testLocalRepositoryHouseExistence(){
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepository_HouseCount() {
   
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepository_ReturnsSortedArrayHouses(){
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesBynameCaseInsensitively(){
        let stark = Repository.local.house(named: "stArk")
        XCTAssertNotNil(stark)
        XCTAssertEqual(stark?.name, "Stark")
    }
    // given - when - then
    func testLocalRepository_HousesFilteredBy_ReturnsTheCorrectValue() {
        let filtered = Repository.local.houses {
            $0.count == 1
        }
        XCTAssertEqual(filtered.count, 1)
    }
}
