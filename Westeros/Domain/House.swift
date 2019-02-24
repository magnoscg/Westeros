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
    let wikiURL: URL
    private var _members: Members
    
    //Mark: Initialization
    init(name: String, sigil: Sigil, words: Words, wikiURL: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = wikiURL
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else {return}
        _members.insert(person)
    }
    
    func add(persons: Person...){
        persons.forEach { add(person: $0)        }
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
