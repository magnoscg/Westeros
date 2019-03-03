//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Oscar canton on 3/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    @IBOutlet weak var seasonName: UILabel!
    
    
    var model: Season
    
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.name
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setupUI()
    }
    
    func syncModelWithView() {
        title = model.name
        seasonName.text = model.name
    }
    
    func setupUI() {
        let episodesButton = UIBarButtonItem(title: "Episodios", style: .plain, target: self, action: #selector(displayEpisodes))
        navigationItem.rightBarButtonItems = [episodesButton]
        
    }
    
    @objc func displayEpisodes() {
        let episodesViewControler = EpisodeListViewController(model: model.sortedEpisodes)
        
        navigationController?.pushViewController(episodesViewControler, animated: true)
    }


}

extension SeasonDetailViewController: SeasonListViewControllerDelegate{
    func seasonListViewController(_viewcontroller: SeasonListViewcontroller, didSelectSeason season: Season) {
        model = season
        syncModelWithView()
        
    }
    

    
}

