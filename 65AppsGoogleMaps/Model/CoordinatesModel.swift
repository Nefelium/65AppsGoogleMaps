//
//  CoordinatesModel.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

class CoordinatesModel: Codable {
    
    var features = [FeaturesCoordinate]()
    
    enum CodingKeys: String, CodingKey {
        case features
    }
}

class FeaturesCoordinate: Codable {
    var type = "Feature"
    var properties = Properties()
    var geometry = Geometry()
    
    enum CodingKeys: String, CodingKey {
        case type
        case properties
        case geometry
    }
}

class Properties: Codable {
    var markercolor: String?
    var markersize: String?
    var markersymbol: String?
    var title: String?
    var snippet: String?
    
    enum CodingKeys: String, CodingKey {
        case markercolor = "marker-color"
        case markersize = "marker-size"
        case markersymbol = "marker-symbol"
        case title
        case snippet
    }
}

class Geometry: Codable {
    var type = "Point"
    var coordinates = [Double(), Double()]
    
    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
}
