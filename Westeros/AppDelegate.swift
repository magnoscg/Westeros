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

    var masterViewController: MasterViewController?
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        
        //Crearnos el modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        masterViewController = MasterViewController(houses: houses, seasons: seasons)
        //Asignamos el rootViewController del window*/
        window?.rootViewController = masterViewController
        
        return true
        
        
        
        
        
       /* //Creamos los controladores ( el que irá en master, y el que irá en el detail)
        let houseListViewController = HouseListViewController(model: houses)
        let seasonListViewController = SeasonListViewcontroller(model: seasons)
        
        //Recuperar la ultima casa seleecionada (si hay alguna)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        let lastSeasonSelected = seasonListViewController.lastSelectedSeason()
        
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        let seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        
        // Asignamos delegados
        // Un objeto solo puede tener un delegado
        // Un objeto puede ser delegado de muchos otros objetos
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
 
        //UItabBar
       
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [houseListViewController.wrappedInNavigation(),seasonListViewController.wrappedInNavigation()]
        
        // Creamos el split view controller y asignamos los controladores
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [tabBarController, houseDetailViewController.wrappedInNavigation(),seasonDetailViewController.wrappedInNavigation()]
        
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [houseListViewController.wrappedInNavigation(), houseDetailViewController.wrappedInNavigation()]*/
        
    }
}


