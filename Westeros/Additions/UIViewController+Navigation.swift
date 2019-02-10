//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Oscar canton on 5/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
