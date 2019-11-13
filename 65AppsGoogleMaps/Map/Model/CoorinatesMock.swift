//
//  CoorinatesMock.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 11.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

struct CoordinatesMock {
    
    let data = [POIItem(position: CLLocationCoordinate2D(latitude: 60.1841232, longitude: 24.9276637), name: "Helsinki", snippet: "Kamppi", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 60.1697809, longitude: 24.9327135), name: "Helsinki", snippet: "Tavastia", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 60.1727480, longitude: 24.9256737), name: "Helsinki", snippet: "Temppeliaukio", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 60.2605952, longitude: 24.6647078), name: "Espoo", snippet: "Lake Bodom", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 60.3176409, longitude: 24.9651579), name: "Vantaa", snippet: "Airport", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 59.9905525, longitude: 29.7787134), name: "Санкт-Петербург", snippet: "Кронштадт", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 59.8826789, longitude: 29.9038036), name: "Санкт-Петербург", snippet: "Петергоф", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 59.9490246, longitude: 30.2437857), name: "Санкт-Петербург", snippet: "Васильевский остров", locationTypeID: .zero),
                POIItem(position: CLLocationCoordinate2D(latitude: 59.8591264, longitude: 30.0869622), name: "Санкт-Петербург", snippet: "Сергиевская слобода", locationTypeID: .zero)
]
    
    let typed = [POIItem(position: CLLocationCoordinate2D(latitude: 57.1843238, longitude: 48.9276637), name: "Item 1", snippet: "AAA", locationTypeID: .man),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.1697809, longitude: 48.9327135), name: "Item 2", snippet: "BBB", locationTypeID: .step),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.1727480, longitude: 48.9256737), name: "Item 3", snippet: "CCC", locationTypeID: .bicycle),
                 POIItem(position: CLLocationCoordinate2D(latitude: 56.2605952, longitude: 48.6647098), name: "Item 4", snippet: "DDD", locationTypeID: .bicycle),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.3170409, longitude: 47.9611579), name: "Item 5", snippet: "EEE", locationTypeID: .step),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.9905525, longitude: 48.7087134), name: "Item 6", snippet: "FFF", locationTypeID: .step),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.8902789, longitude: 48.9038036), name: "Item 7", snippet: "GGG", locationTypeID: .man),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.0816789, longitude: 48.0138536), name: "Item 8", snippet: "HHH", locationTypeID: .step),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.8806789, longitude: 49.0038026), name: "Item 8", snippet: "JJJ", locationTypeID: .man),
                 POIItem(position: CLLocationCoordinate2D(latitude: 57.1950126, longitude: 48.2435837), name: "Item 10", snippet: "III", locationTypeID: .bicycle)
    ]
}
