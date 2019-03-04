//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Oscar canton on 23/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var model: [Person]
    
    //Mark: Initialization
    
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Miembros de la Casa"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Error tipico
        // no olvidar
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //nos damos de alta en las notificaciones, Tan pronto como te des de alta implementa el codigo para darte de baja.
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(houseDidChange(notification:)),
                                       name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME),
                                       object: nil) // Object es quien manda la notificacion

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        
    }
    
    //Mark: Notification
    
    @objc func houseDidChange(notification: Notification) {
        //Sacar el userInfo y Sacar la casa del UserInfo
        guard let info = notification.userInfo,
            let house = info[HOUSE_KEY] as? House else {
                return
        }
        
        // Actualizar mi modelo
        
        model = house.sortedMembers
        //Sincronizar modelo y vista
        tableView.reloadData()
        
        let backButton = UIBarButtonItem(title: house.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}



extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Descubrir la persona
        let person = model[indexPath.row]
        
        //Pedir una celda a la tabla ( si es que la tiene), o si no, crearla.
        let cellId = "MemberCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sincronizar modelo y vista
        cell?.textLabel?.text = person.fullname
        cell?.detailTextLabel?.text = person.alias
            
            
        // Devolver la celda
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = model[indexPath.row]
        
        let memberDetailViewController = MemberDetailViewController(model: person)
        
        memberDetailViewController.delegate = self
        
        navigationController?.pushViewController(memberDetailViewController, animated: true)
    }
    
}
extension MemberListViewController: UITableViewDelegate {
    
}

extension MemberListViewController: MemberDetailViewControllerDelegate {
    func memberDetailViewController(_ viewController: MemberDetailViewController, house: House) {
        self.model = house.sortedMembers
        tableView.reloadData()
        viewController.delegate = self
    }
    
    
}



