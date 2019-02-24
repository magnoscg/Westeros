//
//  Character.swift
//  Westeros
//
//  Created by Oscar canton on 31/1/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

final class Person {
    
    //MARK: Properties
    let name: String
    private let _alias: String?
    let house: House
    
    //propiedades computadas
    var alias: String{
        get {
//            if let alias = _alias{
//                return alias
//            }
//            else{
//                return ""
//            guard let alias = _alias else {
//                // no existe
//                return ""
//            }
//            //existe y está en alias
//            return alias
            
            return _alias ?? ""
        }
    }
    
    //Mark: Initialization
    
    init(name: String,alias: String? = nil ,house: House) {
        self.name = name
        self._alias = alias
        self.house = house
    }
    
//    convenience init(name: String, house: House) {
//        self.init(name: name, alias: nil, house: house)
//    }
    
}

extension Person {
    var fullname: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name) \(house.name)"
    }
    
    var proxyForComparison : String {
        return fullname
    }
    
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}
    
extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
        
}
    
    

