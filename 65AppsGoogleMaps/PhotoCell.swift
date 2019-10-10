//
//  PhotoCell.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 09.10.2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell, NibLoadable, Reusable {
    
    @IBOutlet weak var photo: UIImageView!
    
    func configure(data: String) {
        photo.image = UIImage(named: data)
    }
    
}
