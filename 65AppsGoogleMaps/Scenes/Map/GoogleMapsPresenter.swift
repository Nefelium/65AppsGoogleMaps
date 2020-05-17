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
    func isMarkerTapped(mapPoint: POIItem)
    func showData(data: [MapPointType])
    func goToDataPage(object: ObjectData)
    func setCoordinatesFromServer()
    func setCoordinatesFromModel()
    func makeClusterItems(clusterItemCount: Int,
                          kCameraLatitude: Double,
                          kCameraLongitude: Double)
    func errorDidReceive(with message: String)
    func viewDidLoad()
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
    
    func viewDidLoad() {
        view?.setupMapView()
        view?.setupButtons()
        view?.initClusterManager()
        setCoordinatesFromModel()
        setCoordinatesFromServer()
        makeClusterItems(clusterItemCount: 30, kCameraLatitude: -13.38201457, kCameraLongitude: 21.39410334)
        makeClusterItems(clusterItemCount: 22, kCameraLatitude: -73.92201851, kCameraLongitude: 9.31410334)
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
    
    func goToDataPage(object: ObjectData) {
        router.goToDataViewController(object: object)
    }
    
    func errorDidReceive(with message: String) {
        router.showAlert(message: message)
    }
    
    func isMarkerTapped(mapPoint: POIItem) {
        interactor.setFakeDataFromServer(mapPoint: mapPoint)
    }
    
    func makeClusterItems(clusterItemCount: Int,
                          kCameraLatitude: Double,
                          kCameraLongitude: Double) {
        let generatedClusterItems = interactor.generateClusterItems(count: clusterItemCount,
                                                                    lat: kCameraLatitude,
                                                                    long: kCameraLongitude)
        showData(data: generatedClusterItems)
    }
}
