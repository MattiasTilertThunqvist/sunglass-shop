//
//  DismissRoundButton.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-12.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class DismissRoundButton: UIButton {
    
    // MARK: Properties
    
    var buttonSize = CGSize(width: 40, height: 40)
    
    // MARK: Init
    
    public init(buttonSize: CGSize) {
        super.init(frame: .zero)
        self.buttonSize = buttonSize
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.sunglassDarkGrey.cgColor
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = buttonSize.height / 2

        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonSize.height)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonSize.width)
        
        addConstraints([heightConstraint, widthConstraint])
        setNeedsLayout()
    }
}



