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
        window?.backgroundColor = UIColor.red
        
        //Crearnos el modelo
        let houses = Repository.local.houses

        
        //Creamos el controlador
        
        var controllers = [UIViewController]()
        
        for eachHouse in houses {
            controllers.append(HouseDetailViewController(model: eachHouse).wrappedInNavigation())
        }
       
        //Crear el combinador
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
                
        //Asignamos el rootViewController del window
        
        window?.rootViewController = tabBarController
        
        return true
    }

}

