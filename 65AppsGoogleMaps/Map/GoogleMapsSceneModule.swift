//
//  GoogleMapsSceneModule.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 15.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol GoogleMapsViewModelOutput: class {
    func showData(data: [MapPointType])
}

class GoogleMapsSceneModule {

    var view: (UIViewController & MapViewControllerProtocol & GoogleMapsViewModelOutput)?
    
    init(networkManager: NetworkDataProvider, dataModel: [POIItem], clusterConfigurator: ClusterManager) {
        
    self.view = MapViewController.make()
        
        guard self.view != nil else { return }
        let presenter = GoogleMapsPresenter(view: view)
        let interactor = GoogleMapsInteractor(presenter: presenter, networkManager: networkManager)
        let router = GoogleMapsRouter(view: self.view)
        
        self.view?.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        self.view?.clusterMaker = clusterConfigurator
    }
}
