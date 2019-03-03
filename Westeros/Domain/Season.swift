//
//  Season.swift
//  Westeros
//
//  Created by Oscar canton on 27/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    
    //MARK: Properties
    let name: String
    let releaseDateSeason: Date
    private var _episodes: Episodes
    
    init(name: String, releaseDateSeason: Date) {
        self.name = name
        self.releaseDateSeason = releaseDateSeason
        _episodes = Episodes()
    }
}

//MARK: Protocols
extension Season: CustomStringConvertible {
    var description: String {
        return "\(name)"
    }
}

extension Season {
    var proxyForEquality: String {
        return "\(name)"
    }
    
    var proxyForComparable: Date {
        return releaseDateSeason
    }
}

extension Season: Equatable {
    static func == (lhs: Season,rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparable < rhs.proxyForComparable
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add (episode: Episode) {
        guard episode.season == self else {return}
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...){
        episodes.forEach { add(episode: $0)
        }
    }
}

