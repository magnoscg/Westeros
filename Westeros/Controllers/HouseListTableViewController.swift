//
//  HouseListTableViewController.swift
//  Westeros
//
//  Created by Oscar canton on 14/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class HouseListTableViewController: UITableViewController {
    
    // MARK: Propertiees
    let model: [House]
    
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
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
     
        // DEscubrir cual es la casa que tenemos que mostar
        
        let house = model[indexPath.row]
        
        //Crear una celda
        let cellId = "HouseCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda - house ( view - model)
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        // Devuelvo la celda
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
