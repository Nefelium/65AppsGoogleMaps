//
//  GoogleMapsViewModelOutput.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 15.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol GoogleMapsViewModelOutput: class {
    func showData(data: [MapPointType])
}
