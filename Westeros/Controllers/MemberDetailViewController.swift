//
//  MembersDetailViewController.swift
//  Westeros
//
//  Created by Oscar canton on 4/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

protocol MemberDetailViewControllerDelegate {
    func memberDetailViewController(_ viewController: MemberDetailViewController, house: House)
}

class MemberDetailViewController: UIViewController {

    
    @IBOutlet weak var memberNameLabel: UILabel!
    
    @IBOutlet weak var memberAliasLabel: UILabel!
    
    @IBOutlet weak var UIimage: UIImageView!
    
    
    //MARK: Properties
    
    var model: Person
    var delegate: MemberDetailViewControllerDelegate?
    
    
    
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.fullname
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange(notification:)), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        
        syncModelWithView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Baja en la notificación
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    func syncModelWithView() {
       
        title = model.name
        memberNameLabel.text = model.fullname
        memberAliasLabel.text = model.alias
        UIimage.image = model.house.sigil.image
        
        let backButton = UIBarButtonItem(title: model.house.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    //Mark: Notification
    
    @objc func houseDidChange(notification: Notification) {
        // Sacar el userInfo de la noti, y la casa del userInfo
        guard let info = notification.userInfo,
            let house = info[HOUSE_KEY] as? House else {
                return
        }
        
        // Avisar al delegado
        delegate?.memberDetailViewController(self, house: house)
        
        navigationController?.popViewController(animated: true)
    }
}
