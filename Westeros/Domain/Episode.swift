//
//  Episode.swift
//  Westeros
//
//  Created by Oscar canton on 27/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

final class Episode {
    
    //MARK: Properties
    let title: String
    let releaseDate: Date
    weak var season: Season?
    
    //Mark: Initialization
    init(title: String , releaseDate: Date, season: Season?) {
        self.title = title
        self.releaseDate = releaseDate
        self.season = season
        
    }
}
//MARK: Protocols
extension Episode: CustomStringConvertible {
    var description: String {
        return "\(title)"
    }
}
// Proxys for Equality and Comparable
extension Episode {
    var proxyForEquality: String {
        return "\(title)"
    }
    
    var proxyForComparable: Date {
        return releaseDate
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode,rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparable < rhs.proxyForComparable
    }
}

