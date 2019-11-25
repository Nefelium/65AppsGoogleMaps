//
//  GoogleMapsPresenter.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol GoogleMapsPresenterProtocol: class {
    var interactor: GoogleMapsInteractor! { get set }
    var router: GoogleMapsRouterProtocol! { get set }
    func isMarkerTapped(title: String, snippet: String)
    func showData(data: [MapPointType])
    func getCoordinatesFromServer()
    func getCoordinatesFromModel()
    func makeClusterItems(clusterManager: GMUClusterManager,
                          clusterItemCount: Int,
                          kCameraLatitude: Double,
                          kCameraLongitude: Double)
    func makeMarkersWithIcons(marker: GMSMarker, locations: [MapPointType], clusterManager: GMUClusterManager)
}

class GoogleMapsPresenter: GoogleMapsPresenterProtocol {
    
    weak var view: (MapViewControllerProtocol & GoogleMapsViewModelOutput)!
    var interactor: GoogleMapsInteractor!
    var router: GoogleMapsRouterProtocol!
    
    init(view: (UIViewController & MapViewControllerProtocol & GoogleMapsViewModelOutput)?) {
        self.view = view
    }
    
    func getCoordinatesFromServer() {
        interactor.getCoordinatesFromServer()
    }
    
    func getCoordinatesFromModel() {
        interactor.getCoordinatesFromModel()
    }
    
    func showData(data: [MapPointType]) {
        view.showData(data: data)
    }
    
    func isMarkerTapped(title: String, snippet: String) {
        router.goToDataViewController(title: title, snippet: snippet)
    }
    
    func makeClusterItems(clusterManager: GMUClusterManager,
                          clusterItemCount: Int,
                          kCameraLatitude: Double,
                          kCameraLongitude: Double) {
        interactor.generateClusterItems(clusterManager: clusterManager,
                                        clusterItemCount: 10,
                                        kCameraLatitude: -13.38201457,
                                        kCameraLongitude: 24.39410334)
    }
    
    func makeMarkersWithIcons(marker: GMSMarker, locations: [MapPointType], clusterManager: GMUClusterManager) {
        for location in locations {
            marker.position = CLLocationCoordinate2DMake(location.lat, location.long)

            //set image
            let imageName = location.locationTypeID.rawValue
            let image = UIImage(named: imageName)?.resize(maxWidthHeight: 25.0)
            marker.icon = image

            marker.userData = location
            interactor.generatePOIItem(clusterManager: clusterManager,
                                      position: marker.position,
                                      name: location.name ?? "",
                                      snippet: location.snippet ?? "",
                                      id: location.locationTypeID)
        }
        clusterManager.cluster()
    }
}
