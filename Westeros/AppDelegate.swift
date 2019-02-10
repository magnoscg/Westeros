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
        let starkSigilImage = UIImage (named: "codeiscoming")!
        let starkSigil = Sigil(image: starkSigilImage , description: "Lobo Huargo")
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León rampante")
        let lannisterHouse = House (name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        
        //Creamos el controlador
        
        let starkViewController = HouseDetailViewController(model: starkHouse)
        
        let lannisterViewController = HouseDetailViewController(model: lannisterHouse)

        //Crear el combinador
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [starkViewController.wrappedInNavigation(),lannisterViewController.wrappedInNavigation()]
                
        //Asignamos el rootViewController del window
        
        window?.rootViewController = tabBarController
        
        return true
    }

}

