//
//  masterViewController.swift
//  Westeros
//
//  Created by Oscar canton on 3/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class MasterViewController: UISplitViewController {

    let houseListViewController: HouseListViewController
    let seasonListViewController: SeasonListViewcontroller
    let houseDetailViewController: HouseDetailViewController
    let seasonDetailViewController: SeasonDetailViewController
    
    var houseListNavigation: UINavigationController!
    var seasonListNavigation: UINavigationController!
    var houseDetailNavigation: UINavigationController!
    var seasonDetailNavigation: UINavigationController!
    
    let tabBarViewController = UITabBarController()
    
    
    init(houses: [House], seasons: [Season]) {
        
        houseListViewController = HouseListViewController(model: houses)
        houseDetailViewController = HouseDetailViewController(model: houseListViewController.lastSelectedHouse())
        
        seasonListViewController = SeasonListViewcontroller(model: seasons)
        seasonDetailViewController = SeasonDetailViewController(model: seasonListViewController.lastSeasonSelected())
        
        // Creamos los navigations
        houseListNavigation = houseListViewController.wrappedInNavigation()
        seasonListNavigation = seasonListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        
        tabBarViewController.viewControllers = [houseListNavigation,seasonListNavigation]
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        
        // Asignamos delegados ipad o iphone
        if UIDevice.current.userInterfaceIdiom == .pad {
            houseListViewController.delegate = houseDetailViewController
            seasonListViewController.delegate = seasonDetailViewController
            

        } else {
            houseListViewController.delegate = houseListViewController
            seasonListViewController.delegate = seasonListViewController
            //houseListViewController.delegate = houseDetailViewController
            //seasonListViewController.delegate = seasonDetailViewController
            
        }
        
        tabBarViewController.delegate = self
        viewControllers = [tabBarViewController,houseDetailNavigation]
        preferredDisplayMode = .allVisible
        
        
        super.viewDidLoad()
       
    }

    
}

extension MasterViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if isCollapsed == false {
            if tabBarController.selectedIndex == 1 {
                show(seasonDetailNavigation, sender: self)
            } else {
                
                show(houseDetailViewController,sender: self)
            }
        }
    }
}
