//
//  ClusterItemMaker.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 11.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation
import GoogleMaps

class ClusterItemMaker {
    var mapPoints: [Point]
  //  let mapPoints = CoordinatesMock().data
    
    init(mapPoints: [Point]) {
        self.mapPoints = mapPoints
    }
    
   func prepareItems(clusterManager: GMUClusterManager) {
       for item in mapPoints {
        let position = CLLocationCoordinate2DMake(item.lattitude, item.longitude)
        let mapItem = POIItem(position: position, name: item.title, snippet: item.snippet, locationTypeID: .zero)
        clusterManager.add(mapItem)
       }
   }
}
