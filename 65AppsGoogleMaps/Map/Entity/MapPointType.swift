//
//  MapPointType.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 18.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol MapPointType {
    var lat: Double { get }
    var long: Double { get }
    var title: String? { get }
    var snippet: String? { get }
    var locationTypeID: LocationTypes { get }
}
