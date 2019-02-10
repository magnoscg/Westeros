//
//  House.swift
//  Westeros
//
//  Created by Oscar canton on 31/1/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

typealias Members = Set<Person>
typealias Words = String

final class House {
    //MARK: Properties
    let name: String
    let sigil: Sigil
    let words: Words
    private var _members: Members
    
    //Mark: Initialization
    init(name: String, sigil: Sigil, words: Words) {
        self.name = name
        self.sigil = sigil
        self.words = words
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    func add(person: Person) {
        guard person.house.name == name else {return}
        _members.insert(person)
    }
}

extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
    
    
}

extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    var proxyForComparison: String {
        return name
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}
