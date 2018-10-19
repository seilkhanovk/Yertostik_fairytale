//
//  DesignableVolumeSlider.swift
//  Ertegi
//
//  Created by Kuanysh on 21.08.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableVolumeSlider: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    @IBInspectable var thumbHighlightedImage: UIImage? {
        didSet {
            setThumbImage(thumbHighlightedImage, for: .highlighted)
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 3.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}
