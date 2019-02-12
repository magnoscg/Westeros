//
//  WikiViewController.swift
//  Westeros
//
//  Created by Oscar canton on 11/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let model: House
    
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
    }
    
    func syncModelWithView() {
        title = model.name
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }


}
