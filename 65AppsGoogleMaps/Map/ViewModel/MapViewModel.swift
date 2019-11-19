//
//  MapViewModel.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol MapViewModelProtocol: class {
    func setCoordinatesFromModel()
    func generatePOIItem(clusterManager: GMUClusterManager, position: CLLocationCoordinate2D, name: String, snippet: String, id: LocationTypes)
}

class MapViewModel: MapViewModelProtocol {
    
    var view: GoogleMapsViewModelOutput?
    var router: GoogleMapsRouterProtocol
    
    // parsing local JSON with my coordinates
    var networkManager: NetworkDataProvider
    var data: [POIItem]
    
    init(view: GoogleMapsViewModelOutput?, router: GoogleMapsRouterProtocol, networkManager: NetworkDataProvider, data: [POIItem]) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        self.data = data
    }
    
    func setCoordinatesFromServer() {
        networkManager.getCoordinates { [weak self] result, error in
            guard let self = self else { return }
            guard let result = result else {
                guard let error = error else { return }
                self.router.showAlert(message: error.localizedDescription)
                return }
            self.view?.showData(data: result.features)
        }
    }
    
    func setCoordinatesFromModel() {
     view?.showData(data: CoordinatesMock().data)
    }
    
    func generatePOIItem(clusterManager: GMUClusterManager, position: CLLocationCoordinate2D, name: String, snippet: String, id: LocationTypes) {
        
        let item = POIItem(lat: position.latitude,
                           long: position.longitude,
                           name: name,
                           snippet: snippet,
                           locationTypeID: id)
        clusterManager.add(item)
    }
    
    // заглушка для данных - генерация элементов в определенной области
    func generateClusterItems(clusterManager: GMUClusterManager, clusterItemCount: Int, kCameraLatitude: Double, kCameraLongitude: Double) {
         let extent = 0.2
         for index in 1...clusterItemCount {
           let lat = kCameraLatitude + extent * randomScale()
           let long = kCameraLongitude + extent * randomScale()
           let name = "Item \(index)"
            let item = POIItem(lat: lat,
                               long: long,
                               name: name,
                               snippet: "[generated]",
                               locationTypeID: .zero)
           clusterManager.add(item)
         }
       }
       
       private func randomScale() -> Double {
         return Double(arc4random()) / Double(UINT32_MAX) * 3.0 - 2.0
       }
}
