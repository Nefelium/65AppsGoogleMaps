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
        let router = GoogleMapsRouter(view: self.view)
        let interactor = GoogleMapsInteractor(networkManager: networkManager)
        let presenter = GoogleMapsPresenter(view: view, router: router, interactor: interactor)
        
        self.view?.presenter = presenter
        interactor.presenter = presenter
        self.view?.clusterMaker = clusterConfigurator
    }
}
