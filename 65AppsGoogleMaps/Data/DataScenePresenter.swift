//
//  DataPresenter.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 20.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol DataScenePresenterProtocol: class {
    var interactor: DataSceneInteractorProtocol { get set }
    var router: DataSceneRouterProtocol { get set }
    var pageTitle: String? { get set }
    var snippet: String? { get set }
    var photoNames: [String] { get set }
    func closeButtonClicked()
    func openDirectionsClicked()
    func callsTapped()
    func websiteTapped()
    func favoritesTapped()
    func shareTapped()
}

class DataScenePresenter: DataScenePresenterProtocol {
    
    weak var view: DataViewControllerProtocol?
    var interactor: DataSceneInteractorProtocol
    var router: DataSceneRouterProtocol
    
    var photoNames = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var pageTitle: String?
    var snippet: String?
    
    init(view: DataViewControllerProtocol?,
         interactor: DataSceneInteractorProtocol,
         router: DataSceneRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func closeButtonClicked() {
        router.closeViewController()
    }
    
    func openDirectionsClicked() {
        
    }
    
    func callsTapped() {
        
    }
    
    func websiteTapped() {
        
    }
    
    func favoritesTapped() {
        
    }
    
    func shareTapped() {
        
    }
}
