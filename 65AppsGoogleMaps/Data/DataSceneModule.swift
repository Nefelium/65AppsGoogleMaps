//
//  DataSceneModule.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 20.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol DataSceneModuleProtocol: class {
    
}

class DataSceneModule: DataSceneModuleProtocol {
    
    var view: (UIViewController & DataViewControllerProtocol)?
    
    init() {
        self.view = DataViewController.make()
        let interactor = DataSceneInteractor()
        let router = DataSceneRouter(view: view)
        let presenter = DataScenePresenter(view: view, interactor: interactor, router: router)
        
        view?.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
