//
//  RoundButton.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-12.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    var buttonSize = CGSize(width: 50, height: 50)

    // MARK: Init
    
    public init(buttonSize: CGSize) {
        super.init(frame: .zero)
        self.buttonSize = buttonSize
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setup()
    }

    // MARK: View
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = buttonSize.height / 2
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonSize.height)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonSize.width)
        addConstraints([heightConstraint, widthConstraint])
        setNeedsLayout()
    }
}
