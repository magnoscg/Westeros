//
//  AppDelegate.swift
//  Westeros
//
//  Created by Oscar canton on 31/1/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        
        //Crearnos el modelo
        let houses = Repository.local.houses
  
        //Crear el combinador
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = houses.map {HouseDetailViewController(model: $0)
            .wrappedInNavigation()}
                
        //Asignamos el rootViewController del window
        window?.rootViewController = tabBarController
        
        return true
    }

}

