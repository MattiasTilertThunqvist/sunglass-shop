//
//  SmallButton.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-03.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class SmallButton: UIButton {
    
    // MARK: Properties
    
    let inset: CGFloat = 15
    let buttonHeight: CGFloat = 30
    
    enum ColorScheme {
        case grayOnTransparent
        case whiteOnGray
    }
    
    var colorScheme = ColorScheme.whiteOnGray {
        didSet {
            switch colorScheme {
            case .grayOnTransparent:
                backgroundColor = .clear
                setTitleColor(.sunglassDarkGrey, for: .normal)
                layer.borderWidth = 1
                layer.borderColor = UIColor.sunglassDarkGrey.cgColor
            case .whiteOnGray:
                backgroundColor = .sunglassDarkGrey
                setTitleColor(.white, for: .normal)
            }
        }
    }
    
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
    
    // MARK: Overrides
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + inset * 4.0, height: size.height)
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.sunglassRegularFont(.medium)
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = false
        layer.cornerRadius = buttonHeight / 2
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonHeight)
        addConstraint(heightConstraint)

        setNeedsLayout()
    }
}
