//
//  EpisodeDecodable.swift
//  Westeros
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

struct EpisodeDecodable: Decodable {
    
    var episodio: Int
    var titulo: String
    var dirigido: String
    var escrito: String
    var fecha: String
    var resumen: String

}

