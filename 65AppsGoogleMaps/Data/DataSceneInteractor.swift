//
//  DataSceneInteractor.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 20.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol DataSceneInteractorProtocol: class {
    var presenter: DataScenePresenterProtocol! { get set }
}

class DataSceneInteractor: DataSceneInteractorProtocol {
    
    weak var presenter: DataScenePresenterProtocol!
    
    init(presenter: DataScenePresenter) {
        self.presenter = presenter
    }
}
