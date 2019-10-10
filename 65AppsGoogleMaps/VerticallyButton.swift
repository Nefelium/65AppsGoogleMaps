//
//  VerticallyButton.swift
//  65AppsGoogleMaps
//
//  Created by Mikhail Fogel on 07/10/2019.
//  Copyright © 2019 65apps. All rights reserved.
//

import UIKit

class VerticallyButton: UIButton {
    
    var padding: CGFloat = 8.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel!.numberOfLines = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel!.numberOfLines = 2
        titleLabel!.textAlignment = NSTextAlignment.center
    }
    
    override var intrinsicContentSize: CGSize {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        if let titleSize = titleLabel?.sizeThatFits(maxSize), let imageSize = imageView?.sizeThatFits(maxSize) {
            let width = ceil(max(imageSize.width, titleSize.width))
            let height = ceil(imageSize.height + titleSize.height + padding)
            
            return CGSize(width: width, height: height)
        }
        
        return super.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        if let image = imageView?.image, let title = titleLabel?.attributedText {
            let imageSize = image.size
            let titleSize = title.size()
            
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + padding), right: 0.0)
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
        
        super.layoutSubviews()
    }
}
