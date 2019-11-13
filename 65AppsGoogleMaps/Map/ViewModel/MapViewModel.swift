//
//  MapViewModel.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

class MapViewModel {
    
    // parsing local JSON with my coordinates
    var networkManager = NetworkManager()
    var data = CoordinatesModel()
    
    func configure(completion: @escaping () -> Void) {
        networkManager.getCoordinates(output: CoordinatesModel.self) { [weak self] result in
            guard let self = self else { return }
            self.data = result
            completion()
        }
    }
    
    func setCoordinatesFromModel(data: CoordinatesModel, clusterManager: GMUClusterManager) {
        for item in data.features {
            generatePOIItem(clusterManager: clusterManager,
                            position: CLLocationCoordinate2DMake(item.geometry.coordinates[1], item.geometry.coordinates[0]),
                            name: item.properties.title ?? "",
                            snippet: item.properties.snippet ?? "",
                            id: .zero)
        }
    }
    
    func generatePOIItem(clusterManager: GMUClusterManager, position: CLLocationCoordinate2D, name: String, snippet: String, id: LocationTypes) {
        let item = POIItem(position: position, name: name, snippet: snippet, locationTypeID: id)
        clusterManager.add(item)
    }
    
    // заглушка для данных - генерация элементов в определенной области
    func generateClusterItems(clusterManager: GMUClusterManager, clusterItemCount: Int, kCameraLatitude: Double, kCameraLongitude: Double) {
         let extent = 0.2
         for index in 1...clusterItemCount {
           let lat = kCameraLatitude + extent * randomScale()
           let lng = kCameraLongitude + extent * randomScale()
           let name = "Item \(index)"
           let item = POIItem(position: CLLocationCoordinate2DMake(lat, lng), name: name, snippet: "[generated]", locationTypeID: .zero)
           clusterManager.add(item)
         }
       }
       
       private func randomScale() -> Double {
         return Double(arc4random()) / Double(UINT32_MAX) * 3.0 - 2.0
       }
}
