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
        houseDetailViewController = HouseDetailViewController(model: houseListViewController.lastHouseSelected())
        
        seasonListViewController = SeasonListViewcontroller(model: seasons)
        seasonDetailViewController = SeasonDetailViewController(model: seasonListViewController.lastSeasonSelected())
        
        tabBarViewController.viewControllers = [houseListViewController.wrappedInNavigation(),seasonListViewController.wrappedInNavigation()]
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegates
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        tabBarViewController.delegate = self
        
        viewControllers = [tabBarViewController,houseDetailViewController.wrappedInNavigation(),seasonDetailViewController.wrappedInNavigation()]
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
