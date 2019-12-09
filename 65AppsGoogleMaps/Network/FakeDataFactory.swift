//
//  FakeDataFactory.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 06.12.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

class FakeDataFactory {
    static private let fakeData: [ObjectData] = [
    ObjectData(id: 0, title: "unknown place", snippet: "no data", rating: 0, direction: 0),
    ObjectData(id: 1, title: "This City", snippet: "is the best place of the world", rating: 1000000, direction: 100),
    ObjectData(id: 2, title: "Good place", snippet: "Recommended to visit! It is great! Happy people, good restaurants, parks, buildings!", rating: 1029, direction: 191),
    ObjectData(id: 3, title: "Normal place", snippet: "Nothing special", rating: 1269, direction: 172),
    ObjectData(id: 4, title: "Simple address", snippet: "Some IT-company here. Best opportunity to start your IT-career", rating: 76, direction: 11),
    ObjectData(id: 5, title: "Good restaurant", snippet: "I ate here", rating: 522, direction: 94),
    ObjectData(id: 6, title: "Bad place", snippet: "Not recommended to visit. Dirty, gloomy and most terrible... Ugly architecture everywhere!", rating: 34, direction: 5),
    ObjectData(id: 7, title: "Circus", snippet: "I laughed out loud", rating: 8, direction: 821),
    ObjectData(id: 8, title: "Rock-club", snippet: "Best slam here", rating: 8, direction: 821),
    ObjectData(id: 9, title: "Sex-shop", snippet: "Red light district with lonely girls, best drinks and more other...", rating: 8, direction: 821),
    ObjectData(id: 10, title: "Island", snippet: "For rest and fishing", rating: 8, direction: 821),
    ObjectData(id: 11, title: "City prison for elderly", snippet: "One grandfather is fucked before lunch, another - after lunch. Which of them is worse?", rating: 900, direction: 55)
    ]
    
    static func getData(by id: Int) -> ObjectData {
        for object in fakeData where object.id == id {
            return object
        }
        return ObjectData()
    }
}
