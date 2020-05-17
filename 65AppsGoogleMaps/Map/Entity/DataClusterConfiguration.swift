//
//  DataClusterConfiguration.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 18.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

struct DataClusterConfiguration: ClusterConfiguratorParameters {
    var mapPoints: [MapPointType]
    var buckets: [NSNumber]?
    var colors: [UIColor]?
}
