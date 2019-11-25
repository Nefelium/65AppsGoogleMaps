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
        let presenter = DataScenePresenter(view: view)
        let interactor = DataSceneInteractor(presenter: presenter)
        let router = DataSceneRouter(viewController: view)
        
        view?.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
