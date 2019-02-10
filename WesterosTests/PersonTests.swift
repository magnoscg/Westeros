//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Oscar canton on 31/1/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {
    
    var ned: Person!
    var arya: Person!
    var starkHouse: House!
    var starkSigil: Sigil!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        ned = Person(name: "Eddard", alias: "Ned" , house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPersonExistence() {
        XCTAssertNotNil(ned)
    }
    
    func testPersonHasFullName() {
            XCTAssertEqual(ned.fullname, "Eddard Stark")
    }
    
    func testPersonHashable() {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonEquality() {
        //Identidad
        XCTAssertEqual(ned, ned)
        //Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(eddard, ned)
        //desigualdad
        XCTAssertNotEqual(ned, arya)
    }
}

