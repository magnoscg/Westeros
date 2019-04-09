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
   
            
        }
        
        
        tabBarViewController.delegate = self
        viewControllers = [tabBarViewController,houseDetailNavigation]
        preferredDisplayMode = .allVisible
        
        customTabBar()
        
        super.viewDidLoad()
       
    }
    
    func customTabBar() {
        
        //TabBar Title size
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 12)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        
        //Icons for tabBarController
        let houseIcon = tabBarViewController.tabBar.items?[0]
        houseIcon?.image = UIImage(named: "house")
        
        
        let seasonIcon = tabBarViewController.tabBar.items?[1]
        seasonIcon?.image = UIImage(named: "season")
        
    }

    
}

extension MasterViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first else { return }
        
        let detailNavigation: UINavigationController
        if type(of: viewController ) == SeasonListViewcontroller.self {
            detailNavigation = seasonDetailNavigation
        } else {
            detailNavigation = houseDetailNavigation
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            showDetailViewController(detailNavigation, sender: nil)
        }
    }
}

