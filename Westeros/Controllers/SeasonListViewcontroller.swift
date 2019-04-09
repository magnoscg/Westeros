//
//  SeasonListViewcontroller.swift
//  Westeros
//
//  Created by Oscar canton on 3/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate: class {
    
    func seasonListViewController(_ viewcontroller: SeasonListViewcontroller,didSelectSeason season: Season)
}

class SeasonListViewcontroller: UITableViewController {
    
    
    //MARK: Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    init(model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Temporadas"
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let season = model[indexPath.row]
        
        let cellId = "SeasonCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = season.name

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let season = model[indexPath.row]
        
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        let notificationCenter = NotificationCenter.default
        
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY: season])
        
        notificationCenter.post(notification)
        
        saveLastSelectedSeason(at: indexPath.row)

    }
}

//Persistencia
extension SeasonListViewcontroller {
    func saveLastSelectedSeason(at index: Int){
        let userDefaults = UserDefaults.standard
        userDefaults.set(index,forKey: LAST_SEASON_KEY)
        userDefaults.synchronize()
        
    }
    func lastSeasonSelected() -> Season {
        let userDefaults = UserDefaults.standard
        
        let index = userDefaults.integer(forKey: LAST_SEASON_KEY)
        
        return season(at: index)
    }
    
    func season(at index: Int) -> Season {
        return model[index]
    }
}

extension SeasonListViewcontroller: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewcontroller: SeasonListViewcontroller, didSelectSeason season: Season) {
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        navigationController?.pushViewController(seasonDetailViewController, animated: true)
    }
    

    
}
