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
    var fakeNetworkManager: FakeNetworkDataProvider { get set }
    var presenter: GoogleMapsPresenterProtocol? { get set }
    func setCoordinatesFromServer()
    func setCoordinatesFromModel()
    func setFakeDataFromServer(mapPoint: POIItem)
    func generatePOIItem(clusterManager: GMUClusterManager,
                         position: CLLocationCoordinate2D,
                         title: String,
                         snippet: String,
                         id: LocationTypes)
    func generateClusterItems(count: Int, lat: Double, long: Double) -> [POIItem]
}

class GoogleMapsInteractor: GoogleMapsInteractorProtocol {
    
    var networkManager: NetworkDataProvider
    var fakeNetworkManager: FakeNetworkDataProvider
    weak var presenter: GoogleMapsPresenterProtocol?
    
    init(networkManager: NetworkDataProvider, fakeNetworkManager: FakeNetworkDataProvider) {
        self.networkManager = networkManager
        self.fakeNetworkManager = fakeNetworkManager
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
    
    func setFakeDataFromServer(mapPoint: POIItem) {
        fakeNetworkManager.getCoordinates(id: mapPoint.locationTypeID.markerId) { [presenter] result in
            if let data = try? result.get() {
                var fakeObject = data
                if mapPoint.title != "" {
                    fakeObject.title = mapPoint.title
                }
                if mapPoint.snippet != "" {
                    fakeObject.snippet = mapPoint.snippet
                }
                presenter?.goToDataPage(object: fakeObject)
            } else {
                presenter?.errorDidReceive(with: result.error?.localizedDescription ?? "")
            }
        }
    }
    
    func setCoordinatesFromModel() {
        presenter?.showData(data: CoordinatesMock().data)
        presenter?.showData(data: CoordinatesMock().typed)
    }
    
    func generatePOIItem(clusterManager: GMUClusterManager, position: CLLocationCoordinate2D, title: String, snippet: String, id: LocationTypes) {
        
        let item = POIItem(lat: position.latitude,
                           long: position.longitude,
                           title: title,
                           snippet: snippet,
                           locationTypeID: id)
        clusterManager.add(item)
    }
    
    func generateClusterItems(count: Int, lat: Double, long: Double) -> [POIItem] {
        return RandomGenerator.shared.generateClusterItems(clusterItemCount: count, kCameraLatitude: lat, kCameraLongitude: long)
    }
}
