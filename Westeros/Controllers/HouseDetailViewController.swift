//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Oscar canton on 4/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    let model: House
    
    
    init (model: House) {
        //Primero , limpio mi mierda
        self.model = model
        //Llamo a super
        
        super.init(nibName: nil, bundle: nil)
        title = model.name
        
    }
    // Chapuza de los de Cupertino realacionada con el miedo a nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setupUI()
    }
    
    func syncModelWithView() {
        
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        navigationItem.rightBarButtonItem = wikiButton
    }
    
    @objc func displayWiki() {
        //Creamos el controlador
        let wikiViewController = WikiViewController(model: model)
        //HAcemos push
        navigationController?.pushViewController(wikiViewController, animated: true)
    }
}
