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
}

class DataSceneRouter: DataSceneRouterProtocol {
    
    weak var view: (UIViewController & DataViewControllerProtocol)?
    
    init(view: (UIViewController & DataViewControllerProtocol)?) {
        self.view = view
    }
    
    func closeViewController() {
        view?.dismiss(animated: true, completion: nil)
    }
}
