//
//  GoogleMapsInteractor.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol GoogleMapsInteractorProtocol {
    var networkManager: NetworkDataProvider { get set }
    var presenter: GoogleMapsPresenterProtocol? { get set }
    func setCoordinatesFromServer()
    func setCoordinatesFromModel()
    func generatePOIItem(clusterManager: GMUClusterManager,
                         position: CLLocationCoordinate2D,
                         name: String,
                         snippet: String,
                         id: LocationTypes)
    func generateClusterItems(count: Int, lat: Double, long: Double) -> [POIItem]
}

class GoogleMapsInteractor: GoogleMapsInteractorProtocol {
    
    var networkManager: NetworkDataProvider
    weak var presenter: GoogleMapsPresenterProtocol?
    
    init(networkManager: NetworkDataProvider) {
        self.networkManager = networkManager
    }
    
    func setCoordinatesFromServer() {
        networkManager.getCoordinates { [presenter] result in
            if let data = try? result.get() {
                presenter?.showData(data: data.features)
            } else {
                presenter?.errorDidReceive(with: result.error?.localizedDescription ?? "")
            }
        }
    }
    
    func setCoordinatesFromModel() {
        presenter?.showData(data: CoordinatesMock().data)
        presenter?.showData(data: CoordinatesMock().typed)
    }
    
    func generatePOIItem(clusterManager: GMUClusterManager, position: CLLocationCoordinate2D, name: String, snippet: String, id: LocationTypes) {
        
        let item = POIItem(lat: position.latitude,
                           long: position.longitude,
                           name: name,
                           snippet: snippet,
                           locationTypeID: id)
        clusterManager.add(item)
    }
    
    func generateClusterItems(count: Int, lat: Double, long: Double) -> [POIItem] {
        return RandomGenerator.shared.generateClusterItems(clusterItemCount: count, kCameraLatitude: lat, kCameraLongitude: long)
    }
}
