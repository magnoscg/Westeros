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
    let model: [Person]
    
    //Mark: Initialization
    
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
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
        
}
extension MemberListViewController: UITableViewDelegate{
    
}
