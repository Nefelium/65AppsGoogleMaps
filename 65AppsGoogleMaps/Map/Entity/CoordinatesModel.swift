//
//  CoordinatesModel.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

struct CoordinatesModel: Codable {
    
    var features: [FeaturesCoordinate]
    
    enum CodingKeys: String, CodingKey {
        case features
    }
}

struct FeaturesCoordinate: Codable {
    var type = "Feature"
    var properties: Properties
    var geometry: Geometry
    
    enum CodingKeys: String, CodingKey {
        case type
        case properties
        case geometry
    }
}

struct Properties: Codable {
    var markercolor: String?
    var markersize: String?
    var markersymbol: String?
    var title: String?
    var snippet: String?
    var locationTypeID: LocationTypes?
    
    enum CodingKeys: String, CodingKey {
        case markercolor = "marker-color"
        case markersize = "marker-size"
        case markersymbol = "marker-symbol"
        case title
        case snippet
    }
}

struct Geometry: Codable {
    var type = "Point"
    var coordinates = [Double(), Double()]
    
    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
}

extension FeaturesCoordinate: MapPointType {

    var lat: Double {
        return geometry.coordinates[1]
    }

    var long: Double {
        return geometry.coordinates[0]
    }

    var title: String? {
        return properties.title
    }

    var snippet: String? {
        return properties.snippet
    }

    var locationTypeID: LocationTypes {
        return properties.locationTypeID ?? .zero
    }
}
