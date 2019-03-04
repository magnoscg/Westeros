//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Oscar canton on 3/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit


protocol EpisodeDetailViewControllerDelegate {
    func episodeDetailViewController(_ viewController: EpisodeDetailViewController, season: Season)
}

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var directedLabel: UILabel!
    @IBOutlet weak var writenLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: Episode
    var delegate: EpisodeDetailViewControllerDelegate?
    
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.seasonDidChange(notification:)), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        syncModelWithView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Baja en la notificación
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // Mark: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Sacar el userInfo de la noti, y la casa del userInfo
        guard let info = notification.userInfo,
            let season = info[SEASON_KEY] as? Season else {
                return
        }
        
        // Avisar al delegado
        delegate?.episodeDetailViewController(self, season: season)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func syncModelWithView() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        title = model.title
        episodeName.text = model.title
        directedLabel.text = model.dirigido
        writenLabel.text = model.escrito
        dateLabel.text = formatter.string(from: model.releaseDate)
        print(formatter.string(from: model.releaseDate))
        descriptionLabel.text = model.resumen
        
        let backButton = UIBarButtonItem(title: model.season?.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}



