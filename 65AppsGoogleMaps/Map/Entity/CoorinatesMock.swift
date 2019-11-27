//
//  CoorinatesMock.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 11.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

struct CoordinatesMock {
    
    let data = [POIItem(lat: 60.1841232, long: 24.9276637, name: "Helsinki", snippet: "Kamppi", locationTypeID: .zero),
                POIItem(lat: 60.1697809, long: 24.9327135, name: "Helsinki", snippet: "Tavastia", locationTypeID: .zero),
                POIItem(lat: 60.1727480, long: 24.9256737, name: "Helsinki", snippet: "Temppeliaukio", locationTypeID: .zero),
                POIItem(lat: 60.2605952, long: 24.6647078, name: "Espoo", snippet: "Lake Bodom", locationTypeID: .zero),
                POIItem(lat: 60.3176409, long: 24.9651579, name: "Vantaa", snippet: "Airport", locationTypeID: .zero),
                POIItem(lat: 59.9905525, long: 29.7787134, name: "Санкт-Петербург", snippet: "Кронштадт", locationTypeID: .zero),
                POIItem(lat: 59.8826789, long: 29.9038036, name: "Санкт-Петербург", snippet: "Петергоф", locationTypeID: .zero),
                POIItem(lat: 59.9490246, long: 30.2437857, name: "Санкт-Петербург", snippet: "Васильевский остров", locationTypeID: .zero),
                POIItem(lat: 59.8591264, long: 30.0869622, name: "Санкт-Петербург", snippet: "Сергиевская слобода", locationTypeID: .zero)
]
    
    let typed = [POIItem(lat: 57.5843238, long: 49.9276637, name: "Item 1", snippet: "AAA", locationTypeID: .man),
                 POIItem(lat: 57.1697809, long: 48.9327135, name: "Item 2", snippet: "BBB", locationTypeID: .step),
                 POIItem(lat: 57.1727480, long: 48.9256737, name: "Item 3", snippet: "CCC", locationTypeID: .bicycle),
                 POIItem(lat: 56.2605952, long: 48.6647098, name: "Item 4", snippet: "DDD", locationTypeID: .bicycle),
                 POIItem(lat: 57.3170409, long: 47.9611579, name: "Item 5", snippet: "EEE", locationTypeID: .step),
                 POIItem(lat: 57.9905525, long: 48.7087134, name: "Item 6", snippet: "FFF", locationTypeID: .step),
                 POIItem(lat: 57.8902289, long: 48.9038036, name: "Item 7", snippet: "GGG", locationTypeID: .man),
                 POIItem(lat: 57.0116789, long: 48.0138136, name: "Item 8", snippet: "HHH", locationTypeID: .step),
                 POIItem(lat: 57.8456789, long: 49.0038026, name: "Item 8", snippet: "JJJ", locationTypeID: .man),
                 POIItem(lat: 57.1950126, long: 48.2535837, name: "Item 10", snippet: "III", locationTypeID: .bicycle)
    ]
}
