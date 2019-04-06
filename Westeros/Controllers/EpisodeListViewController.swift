//
//  EpisodeListTableViewController.swift
//  Westeros
//
//  Created by Oscar canton on 3/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

//protocol EpisodeListViewControllerDelegate: class{
//
//    func episodeListViewController(_ viewcontroller: EpisodeListViewController, didSelectEpisode: Episode)
//
//}

class EpisodeListViewController: UITableViewController {
    
    
    //MARK: Properties
    
    var model: [Episode]
    //weak var delegate: EpisodeListViewControllerDelegate?
    
    init(model: [Episode]){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Episodios"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange(notification:)), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        
        //syncModelWithView()
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        //Nos damos e baja de las notificaciones
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.removeObserver(self)
//    }
    
    //Mark: Notifications
    
    @objc func seasonDidChange(notification: Notification) {
        
        let info = notification.userInfo!
        guard let season = info[SEASON_KEY] as? Season else{
            return
            
        }
        
        model = season.sortedEpisodes
        
        syncModelWithView()
        
        let backButton = UIBarButtonItem(title: season.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
    
    
    func syncModelWithView() {
        tableView.reloadData()
    
    }
    


    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let episode = model[indexPath.row]
        
        //Crear una celda
        let cellId = "EpisodeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda - episode ( view - model)
        cell?.textLabel?.text = episode.title
        
        
        // Devuelvo la celda
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    //MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar la casa que se ha pulsado
        
        let episode = model[indexPath.row]
        
        // Avisamos al delegado
        
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        
        //episodeDetailViewController.delegate = self
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
        
    }
}

//extension EpisodeListViewController: EpisodeDetailViewControllerDelegate {
//    func episodeDetailViewController(_ viewController: EpisodeDetailViewController, season: Season) {
//        self.model = season.sortedEpisodes
//        syncModelWithView()
//        viewController.delegate = self
//        
//}


