//
//  HouseListTableViewController.swift
//  Westeros
//
//  Created by Oscar canton on 14/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

// Definir nuestro propio delegado
protocol HouseListViewControllerDelegate: class {
    //should
    // Will
    // Did
    func houseListViewController(_ viewcontroller: HouseListViewController,didSelectHouse: House)
    
    
}

class HouseListViewController: UITableViewController {
    
    // MARK: Propertiees
    let model: [House]
    weak var delegate: HouseListViewControllerDelegate? // Se inicializa a nil por defecto
    
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar la casa que se ha pulsado
        
        let house = model[indexPath.row]
        
        // Avisamos al delegado
        
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Emitir la misma info por notificaciones
        let notificationCenter = NotificationCenter.default
        
        //Creamos la notificacion
        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY: house])
        
        // enviamos la notificacion
        notificationCenter.post(notification)
        
        // Guardar la casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
        
        
        /*let houseDetailViewController = HouseDetailViewController(model: house)

        //vamos a mostrarlo (push)
        navigationController?.pushViewController(houseDetailViewController, animated: true)*/
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at index: Int){
        // UserDefaults será nuestro motor de persistencia
        let userDefaults = UserDefaults.standard
        
        // Escribimnos el index en una key
        userDefaults.set(index,forKey: LAST_HOUSE_KEY)
        
        // Guardamos
        userDefaults.synchronize() // POR SI ACASO (DEPRECATED EN BREVES)
    }
    
    func lastSelectedHouse() -> House {
        // UserDefaults , lo recuperamos
        let userDefaults = UserDefaults.standard
        
        // Leemos de nuestro motor de persistencia
        let index = userDefaults.integer(forKey: LAST_HOUSE_KEY) // 0 es default
        
        // Devolvemos la casa situada en el index
        return house(at: index)
    }
    
    func house(at index: Int) -> House {
        return model[index]
    }
}
