//
//  UIViewController.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 15.11.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import Foundation

extension UIViewController {
    class var id: String {
        print(String(describing: self))
        return String(describing: self)
    }
    
    class func make<T>() -> T? {
//    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.id) as? T
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: self.id) as? T
        dump(vc)
        return vc
    }
}
