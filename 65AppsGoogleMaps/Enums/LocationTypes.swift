//
//  LocationTypes.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 14.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

enum LocationTypes: String {
    case zero
    case man
    case step
    case bicycle
}

extension LocationTypes {
    var icon: UIImage? {
        switch self {
        case .zero: return nil
        case .man: return UIImage(named: "typeMan")
        case .step: return UIImage(named: "typeStep")
        case .bicycle: return UIImage(named: "typeBicycle")
        }
    }
}
