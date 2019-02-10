//
//  Sigil.swift
//  Westeros
//
//  Created by Oscar canton on 31/1/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

final class Sigil {
    
    //MARK: Properties
    
    let description: String
    let image: UIImage
    
    //MARK: Initialization
    
    init(image: UIImage, description: String) {
        self.description = description
        self.image = image
    }
}
