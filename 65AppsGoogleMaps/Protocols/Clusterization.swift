//
//  Clusterization.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 08.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol Clusterization: class {
    
    func configureClusterManager(mapView: GMSMapView, buckets: [NSNumber], colors: [UIColor], mapPoints: [Point]) -> (GMUClusterManager, GMUDefaultClusterRenderer)
}
