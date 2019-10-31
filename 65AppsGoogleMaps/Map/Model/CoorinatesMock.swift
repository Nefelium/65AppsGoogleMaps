//
//  CoorinatesMock.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 11.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

struct CoordinatesMock {
    
    let data = [Point(lattitude: 60.1841232, longitude: 24.9276637,  title: "Helsinki", snippet: "Kamppi", locationTypeID: .zero),
                Point(lattitude: 60.1697809, longitude: 24.9327135,  title: "Helsinki", snippet: "Tavastia", locationTypeID: .zero),
                Point(lattitude: 60.1727480, longitude: 24.9256737,  title: "Helsinki", snippet: "Temppeliaukio", locationTypeID: .zero),
                Point(lattitude: 60.2605952, longitude: 24.6647078,  title: "Espoo", snippet: "Lake Bodom", locationTypeID: .zero),
                Point(lattitude: 60.3176409, longitude: 24.9651579,  title: "Vantaa", snippet: "Airport", locationTypeID: .zero),
                Point(lattitude: 59.9905525, longitude: 29.7787134,  title: "Санкт-Петербург", snippet: "Кронштадт", locationTypeID: .zero),
                Point(lattitude: 59.8826789, longitude: 29.9038036,  title: "Санкт-Петербург", snippet: "Петергоф", locationTypeID: .zero),
                Point(lattitude: 59.9490246, longitude: 30.2437857,  title: "Санкт-Петербург", snippet: "Васильевский остров", locationTypeID: .zero),
                Point(lattitude: 59.8591264, longitude: 30.0869622,  title: "Санкт-Петербург", snippet: "Сергиевская слобода", locationTypeID: .zero)
]
    
    let typed = [Point(lattitude: 57.1843238, longitude: 48.9276637,  title: "Item 1", snippet: "AAA", locationTypeID: .man),
                    Point(lattitude: 57.1697809, longitude: 48.9327135,  title: "Item 2", snippet: "BBB", locationTypeID: .step),
                    Point(lattitude: 57.1727480, longitude: 48.9256737,  title: "Item 3", snippet: "CCC", locationTypeID: .bicycle),
                    Point(lattitude: 56.2605952, longitude: 48.6647098,  title: "Item 4", snippet: "DDD", locationTypeID: .bicycle),
                    Point(lattitude: 57.3170409, longitude: 47.9611579,  title: "Item 5", snippet: "EEE", locationTypeID: .step),
                    Point(lattitude: 57.9905525, longitude: 48.7087134,  title: "Item 6", snippet: "FFF", locationTypeID: .step),
                    Point(lattitude: 57.8902789, longitude: 48.9038036,  title: "Item 7", snippet: "GGG", locationTypeID: .man),
                    Point(lattitude: 57.0816789, longitude: 48.0138536,  title: "Item 8", snippet: "HHH", locationTypeID: .step),
                    Point(lattitude: 57.8806789, longitude: 49.0038026,  title: "Item 8", snippet: "JJJ", locationTypeID: .man),
                    Point(lattitude: 57.1950126, longitude: 48.2435837,  title: "Item 10", snippet: "III", locationTypeID: .bicycle)
    ]
}
