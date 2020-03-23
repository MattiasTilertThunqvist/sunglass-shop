//
//  ExtraLargeTextLabel.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-23.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class ExtraLargeTextLabel: UILabel {
    
    // MARK: Init
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: View
    
    func setup() {
        numberOfLines = 500 //Allow unlimited
        textColor = .sunglassBlack
        font = .sunglassRegularFont(.extraLarge)
    }
}
