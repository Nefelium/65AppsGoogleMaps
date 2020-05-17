//
//  DataRouter.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 20.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol DataSceneRouterProtocol: class {
    func closeViewController()
    func showAlert(message: String)
}

class DataSceneRouter: DataSceneRouterProtocol {
    
    weak var view: (UIViewController & DataViewControllerProtocol)?
    
    init(view: (UIViewController & DataViewControllerProtocol)?) {
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
    
    func closeViewController() {
        view?.dismiss(animated: true, completion: nil)
    }
}
