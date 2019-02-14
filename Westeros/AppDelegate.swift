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
  
        //Creamos el controlador de la tabla
        let houseListViewController = HouseListTableViewController(model: houses).wrappedInNavigation()
        
        
                
        //Asignamos el rootViewController del window
        window?.rootViewController = houseListViewController
        
        return true
    }

}

