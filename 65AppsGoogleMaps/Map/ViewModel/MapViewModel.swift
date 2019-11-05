//
//  MapViewModel.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 21.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

class MapViewModel {
    
    // parsing local JSON with my coordinates
    var networkManager = NetworkManager()
    var data = CoordinatesModel()
    
    func configure(completion: @escaping () -> Void) {
        networkManager.getCoordinates() { [weak self] result in
            guard let self = self else { return }
            self.data = result
            completion()
        }
    }
}
