//
//  GoogleMapsPresenter.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol GoogleMapsPresenterProtocol: class {
    var interactor: GoogleMapsInteractorProtocol { get set }
    var router: GoogleMapsRouterProtocol { get set }
    func isMarkerTapped(title: String, snippet: String)
    func showData(data: [MapPointType])
    func setCoordinatesFromServer()
    func setCoordinatesFromModel()
    func makeClusterItems(clusterManager: GMUClusterManager,
                          clusterItemCount: Int,
                          kCameraLatitude: Double,
                          kCameraLongitude: Double)
}

class GoogleMapsPresenter: GoogleMapsPresenterProtocol {
    
    weak var view: (MapViewControllerProtocol & GoogleMapsViewModelOutput)?
    var interactor: GoogleMapsInteractorProtocol
    var router: GoogleMapsRouterProtocol
    
    init(view: (MapViewControllerProtocol & GoogleMapsViewModelOutput)?,
         router: GoogleMapsRouterProtocol,
         interactor: GoogleMapsInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func setCoordinatesFromServer() {
        interactor.setCoordinatesFromServer()
    }
    
    func setCoordinatesFromModel() {
        interactor.setCoordinatesFromModel()
    }
    
    func showData(data: [MapPointType]) {
        view?.showData(data: data)
    }
    
    func isMarkerTapped(title: String, snippet: String) {
        router.goToDataViewController(title: title, snippet: snippet)
    }
    
    func makeClusterItems(clusterManager: GMUClusterManager,
                          clusterItemCount: Int,
                          kCameraLatitude: Double,
                          kCameraLongitude: Double) {
        interactor.generateClusterItems(clusterManager: clusterManager,
                                        clusterItemCount: clusterItemCount,
                                        kCameraLatitude: kCameraLatitude,
                                        kCameraLongitude: kCameraLongitude)
    }
}
