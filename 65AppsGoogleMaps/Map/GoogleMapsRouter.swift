//
//  GoogleMapsRouter.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 15.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol GoogleMapsRouterProtocol: class {
    var view: (UIViewController & MapViewControllerProtocol)? { get set }
    func showAlert(message: String)
    func goToDataViewController(title: String, snippet: String)
}

class GoogleMapsRouter: GoogleMapsRouterProtocol {
    
    var view: (UIViewController & MapViewControllerProtocol)?
    
    init(view: (UIViewController & MapViewControllerProtocol)?) {
        self.view = view
    }
    
    func showAlert(message: String) {
        checkIsAlertExists(message: message)
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }

    private func checkIsAlertExists(message: String) {
        if let currentAlert = view?.presentedViewController as? UIAlertController {
            currentAlert.message = (currentAlert.message ?? "") + "\n\nОбновлено: \(message)"
            return
        }
    }
    
    func goToDataViewController(title: String, snippet: String) {
        view?.transitionController(title: title, snippet: snippet)
    }
}
