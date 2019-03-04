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

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var model: House
    
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //nos damos de alta en las notificaciones, Tan pronto como te des de alta implementa el codigo para darte de baja.
        let notificationCenter = NotificationCenter.default
        let name = Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(houseDidChange(notification:)),
                                       name: name,
                                       object: nil) // Object es quien manda la notificacion
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Nos damos de baja en las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        
    }

    
    func syncModelWithView() {
        //Mostramos el loading view y lo animamos
        loadingView.isHidden = false
        loadingView.startAnimating()
        title = model.name
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }
    
    //Mark: Notification
    
    @objc func houseDidChange(notification: Notification) {
        //Sacar el userInfo y Sacar la casa del UserInfo
        guard let info = notification.userInfo,
               let house = info[HOUSE_KEY] as? House else {
            return
        }
        
        // Actualizar mi modelo
        
        model = house
        //Sincronizar modelo y vista
        syncModelWithView()
        let backButton = UIBarButtonItem(title: house.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }


}

extension WikiViewController:WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Detener la animacion del activity indicator
        loadingView.stopAnimating()
        //ocultarlo
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
