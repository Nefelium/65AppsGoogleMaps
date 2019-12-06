//
//  ObjectData.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 06.12.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

struct ObjectData: Codable {
    var id = Int()
    var title = String()
    var snippet = String()
    var rating = Int()
    var direction = Int()
}
