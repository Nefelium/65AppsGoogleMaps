//
//  DataPresenter.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 20.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

protocol DataScenePresenterProtocol: class {
    var pageTitle: String? { get set }
    var snippet: String? { get set }
}

class DataScenePresenter: DataScenePresenterProtocol {
    
    weak var view: (UIViewController & DataViewControllerProtocol)?
    var interactor: DataSceneInteractorProtocol!
    var router: DataSceneRouterProtocol!
    
    var pageTitle: String?
    var snippet: String?
    
    init(view: (UIViewController & DataViewControllerProtocol)?) {
        self.view = view
    }
}
