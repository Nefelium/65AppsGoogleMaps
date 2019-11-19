//
//  Launcher.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 15.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

class Launcher {
    static func launch(with window: UIWindow?) {
        
        let navController = UINavigationController()
        let module = GoogleMapsSceneModule(networkManager: NetworkManager(), dataModel: [POIItem](), clusterConfigurator: ClusterManager())
        guard let view = module.view else { return }
        navController.setViewControllers([view], animated: true)
        
        navController.isNavigationBarHidden = true
        
        window?.rootViewController = navController
    }
}
