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

protocol Clusterization: class {
    func configureClusterManager(mapView: GMSMapView, buckets: [NSNumber], colors: [UIColor], mapPoints: [MapPointType]) -> (GMUClusterManager, GMUDefaultClusterRenderer)
    func addItems(to clusterManager: GMUClusterManager, mapPoints: [MapPointType])
}

class ClusterManager: Clusterization {
    
    func configureClusterManager(mapView: GMSMapView, buckets: [NSNumber], colors: [UIColor], mapPoints: [MapPointType]) -> (GMUClusterManager, GMUDefaultClusterRenderer) {
            let iconGenerator = makeIconGenerator(buckets: buckets, colors: colors)
            let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
            let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
            
            let clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
            return (clusterManager, renderer)
        }
    
    private func makeIconGenerator(buckets: [NSNumber], colors: [UIColor]) -> GMUClusterIconGenerator {
        guard buckets.count != 0, buckets.count == colors.count
            else { return GMUDefaultClusterIconGenerator() }
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: buckets, backgroundColors: colors)
        return iconGenerator
    }
    
    func addItems(to clusterManager: GMUClusterManager, mapPoints: [MapPointType]) {
        for item in mapPoints {
            let mapItem = POIItem(lat: item.lat, long: item.long, title: item.title ?? "", snippet: item.snippet ?? "", locationTypeID: item.locationTypeID)
         clusterManager.add(mapItem)
        }
    }
    
}
