//
//  CoorinatesMock.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 11.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

struct CoordinatesMock {
    
    let data = [POIItem(lat: 60.1841232, long: 24.9276637, title: "Helsinki", snippet: "Kamppi", locationTypeID: .zero),
                POIItem(lat: 60.1697809, long: 24.9327135, title: "Helsinki", snippet: "Tavastia", locationTypeID: .zero),
                POIItem(lat: 60.1727480, long: 24.9256737, title: "Helsinki", snippet: "Temppeliaukio", locationTypeID: .zero),
                POIItem(lat: 60.2605952, long: 24.6647078, title: "Espoo", snippet: "Lake Bodom", locationTypeID: .zero),
                POIItem(lat: 60.3176409, long: 24.9651579, title: "Vantaa", snippet: "Airport", locationTypeID: .zero),
                POIItem(lat: 59.9905525, long: 29.7787134, title: "Санкт-Петербург", snippet: "Кронштадт", locationTypeID: .zero),
                POIItem(lat: 59.8826789, long: 29.9038036, title: "Санкт-Петербург", snippet: "Петергоф", locationTypeID: .zero),
                POIItem(lat: 59.9490246, long: 30.2437857, title: "Санкт-Петербург", snippet: "Васильевский остров", locationTypeID: .zero),
                POIItem(lat: 59.8591264, long: 30.0869622, title: "Санкт-Петербург", snippet: "Сергиевская слобода", locationTypeID: .zero)
]
    
    let typed = [POIItem(lat: 57.5843238, long: 49.9276637, title: "", snippet: "AAA", locationTypeID: .man),
                 POIItem(lat: 57.1697809, long: 48.9327135, title: "Item 2", snippet: "", locationTypeID: .step),
                 POIItem(lat: 57.1727480, long: 48.9256737, title: "Item 3", snippet: "CCC", locationTypeID: .bicycle),
                 POIItem(lat: 56.2605952, long: 48.6647098, title: "Item 4", snippet: "DDD", locationTypeID: .bicycle),
                 POIItem(lat: 57.3170409, long: 47.9611579, title: "Item 5", snippet: "EEE", locationTypeID: .step),
                 POIItem(lat: 57.9905525, long: 48.7087134, title: "Item 6", snippet: "FFF", locationTypeID: .step),
                 POIItem(lat: 57.8902289, long: 48.9038036, title: "Item 7", snippet: "GGG", locationTypeID: .man),
                 POIItem(lat: 57.0116789, long: 48.0138136, title: "Item 8", snippet: "", locationTypeID: .step),
                 POIItem(lat: 57.8456789, long: 49.0038026, title: "Item 9", snippet: "JJJ", locationTypeID: .man),
                 POIItem(lat: 57.1950126, long: 48.2535837, title: "Item 10", snippet: "III", locationTypeID: .bicycle),
                 POIItem(lat: 56.1950126, long: 48.9535830, title: "", snippet: "III", locationTypeID: .bicycle),
                 POIItem(lat: 58.2950125, long: 48.6535832, title: "Item 11", snippet: "", locationTypeID: .step),
                 POIItem(lat: 57.3950726, long: 48.4535835, title: "", snippet: "", locationTypeID: .man)
    ]
}
