//
//  Layer + sunglass.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-12.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

extension CALayer {
    
    func setSunglassShadow() {
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.15
        shadowOffset = CGSize.zero
        shadowRadius = 2
    }
}
