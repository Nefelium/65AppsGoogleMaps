//
//  RandomGenerator.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 02.12.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

class RandomGenerator {
    
    static let shared = RandomGenerator()
    
    // заглушка для данных - генерация элементов в определенной области
    func generateClusterItems(clusterItemCount: Int, kCameraLatitude: Double, kCameraLongitude: Double) -> [POIItem] {
        var clusterItems = [POIItem]()
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
            clusterItems.append(item)
        }
        return clusterItems
    }
    
    private func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 3.0 - 2.0
    }
}
