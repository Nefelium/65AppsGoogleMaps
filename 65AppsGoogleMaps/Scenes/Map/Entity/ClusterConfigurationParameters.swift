//
//  ClusterConfigurationParameters.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 18.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol ClusterConfiguratorParameters {
    var buckets: [NSNumber]? { get }
    var colors: [UIColor]? { get }
    var mapPoints: [MapPointType] { get }
}
