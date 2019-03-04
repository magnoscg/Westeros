//
//  masterViewController.swift
//  Westeros
//
//  Created by Oscar canton on 3/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class MasterViewController: UISplitViewController {

    var houseListViewController: HouseListViewController
    var seasonListViewController: SeasonListViewcontroller
    var houseDetailViewController: HouseDetailViewController
    var seasonDetailViewController: SeasonDetailViewController

    
    var tabBarViewController = UITabBarController()
    
    
    init(houses: [House], seasons: [Season]) {
        
        houseListViewController = HouseListViewController(model: houses)
        seasonListViewController = SeasonListViewcontroller(model: seasons)
        houseDetailViewController = HouseDetailViewController(model: houseListViewController.lastSelectedHouse())
        seasonDetailViewController = SeasonDetailViewController(model: seasonListViewController.lastSelectedSeason())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        let houseListNavigationController = houseListViewController.wrappedInNavigation()
        let seasonListNavigationController = seasonListViewController.wrappedInNavigation()
        let houseDetailNavigationController = houseDetailViewController.wrappedInNavigation()
        let seasonDetailNavigationController = seasonDetailViewController.wrappedInNavigation()
        
        tabBarViewController.viewControllers = [houseListNavigationController,seasonListNavigationController]
        //delegates
        
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        tabBarViewController.delegate = self
        
        viewControllers = [tabBarViewController,houseDetailNavigationController,seasonDetailNavigationController]
    }

}

extension MasterViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (isCollapsed == false){
            if tabBarViewController.selectedIndex == 0 {
                self.delegate = houseListViewController
                show(houseDetailViewController.wrappedInNavigation(), sender: self)
            }else {
                self.delegate = seasonListViewController
                show(seasonDetailViewController.wrappedInNavigation(), sender: self)
            }
        }
    }
}
