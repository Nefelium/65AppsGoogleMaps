//
//  DataSceneInteractor.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 20.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol DataSceneInteractorProtocol: class {
    var presenter: DataScenePresenterProtocol? { get set }
    func setFakePicturesFromServer()
}

class DataSceneInteractor: DataSceneInteractorProtocol {
    
    var fakeNetworkManager = FakeNetworkManager()
    weak var presenter: DataScenePresenterProtocol?
    
    func setFakePicturesFromServer() {
        fakeNetworkManager.getPictures { [presenter] result in
            if let data = try? result.get() {
                presenter?.setPhotoNames(names: data.photos)
            } else {
                presenter?.errorDidReceive(with: result.error?.localizedDescription ?? "")
            }
        }
    }
}
