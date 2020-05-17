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
    var object: ObjectData { get set }
    var photoNames: [String] { get set }
    func viewDidLoad()
    func closeButtonClicked()
    func openDirectionsClicked()
    func callsTapped()
    func websiteTapped()
    func favoritesTapped()
    func shareTapped()
    func setPhotoNames(names: [String])
    func errorDidReceive(with message: String)
}

class DataScenePresenter: DataScenePresenterProtocol {
    
    weak var view: DataViewControllerProtocol?
    var interactor: DataSceneInteractorProtocol
    var router: DataSceneRouterProtocol
    
    var photoNames = [String]()
    var pageTitle: String?
    var snippet: String?
    var object = ObjectData()
    
    init(view: DataViewControllerProtocol?,
         interactor: DataSceneInteractorProtocol,
         router: DataSceneRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.setFakePicturesFromServer()
    }
    
    func closeButtonClicked() {
        router.closeViewController()
    }
    
    func setPhotoNames(names: [String]) {
        photoNames = names
        view?.collectionView.reloadData()
    }
    
    func errorDidReceive(with message: String) {
        router.showAlert(message: message)
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
