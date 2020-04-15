//
//  UIFont + sunglass.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum textSize: CGFloat {
        case small = 12
        case medium = 14
        case large = 16
        case extraLarge = 22
    }
    
    class func sunglassRegularFont(_ textSize: textSize) -> UIFont {
        return UIFont(name: "Apple SD Gothic Neo", size: textSize.rawValue)!
    }
}

