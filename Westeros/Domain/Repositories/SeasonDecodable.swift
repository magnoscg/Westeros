//
//  SeasonDecodable.swift
//  Westeros
//
//  Created by Oscar canton on 1/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

struct SeasonDecodable: Decodable {
    
    var name: String
    var releaseDateSeason: String
    var episodes: [EpisodeDecodable]
    
}
