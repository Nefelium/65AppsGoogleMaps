//
//  GoogleMapsSceneModule.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 15.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

class GoogleMapsSceneModule {

    var view: (UIViewController & MapViewControllerProtocol & GoogleMapsViewModelOutput)?
    
    init(networkManager: NetworkDataProvider, dataModel: [POIItem], clusterConfigurator: ClusterManager) {
        
    self.view = MapViewController.make()
        
        guard self.view != nil else { return }
        let router = GoogleMapsRouter(view: self.view)
        let viewModel = MapViewModel(view: self.view, router: router, networkManager: networkManager, data: dataModel)
        self.view?.viewModel = viewModel
        self.view?.clusterMaker = clusterConfigurator
    }
}
