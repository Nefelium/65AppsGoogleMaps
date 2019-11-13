//
//  ClusterManager.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 05.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

class ClusterManager: Clusterization {
    
    func configureClusterManager(mapView: GMSMapView, buckets: [NSNumber], colors: [UIColor], mapPoints: [POIItem]) -> (GMUClusterManager, GMUDefaultClusterRenderer) {
            let iconGenerator = makeIconGenerator(buckets: buckets, colors: colors)
            let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
            let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
            
            let clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        prepareItems(clusterManager: clusterManager, mapPoints: mapPoints)
            
            return (clusterManager, renderer)
        }
    
    private func makeIconGenerator(buckets: [NSNumber], colors: [UIColor]) -> GMUClusterIconGenerator {
        guard buckets.count != 0, buckets.count == colors.count
            else { return GMUDefaultClusterIconGenerator() }
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: buckets, backgroundColors: colors)
        return iconGenerator
    }
    
    private func prepareItems(clusterManager: GMUClusterManager, mapPoints: [POIItem]) {
        for item in mapPoints {
        let mapItem = POIItem(position: item.position, name: item.name, snippet: item.snippet, locationTypeID: .zero)
         clusterManager.add(mapItem)
        }
    }
    
}
