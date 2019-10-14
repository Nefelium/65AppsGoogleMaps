//
//  POIItem.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 11.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

/// Point of Interest Item which implements the GMUClusterItem protocol.
class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String
    var snippet: String
    var locationTypeID: LocationTypes

    init(position: CLLocationCoordinate2D, name: String, snippet: String, locationTypeID: LocationTypes) {
    self.position = position
    self.name = name
    self.snippet = snippet
    self.locationTypeID = locationTypeID
  }
}
