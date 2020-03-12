//
//  LargeButton.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class LargeButton: UIButton {

    // MARK: Properties

    let inset: CGFloat = 15
    var buttonHeight: CGFloat = 50

    enum ColorScheme {
        case blackOnTransparent
        case goldOnBlack
    }

    var colorScheme = ColorScheme.goldOnBlack {
        didSet {
            switch colorScheme {
            case .blackOnTransparent:
                backgroundColor = .clear
                setTitleColor(.sunglassBlack, for: .normal)
                layer.borderWidth = 1
                layer.borderColor = UIColor.sunglassBlack.cgColor
            case .goldOnBlack:
                backgroundColor = .sunglassBlack
                setTitleColor(.sunglassGold, for: .normal)
            }
        }
    }

    // MARK: Init

    public init(buttonHeight: CGFloat) {
        super.init(frame: .zero)
        self.buttonHeight = buttonHeight
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
    
    // MARK: View

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.sunglassRegularFont(.medium)
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = false
        layer.cornerRadius = 2

        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonHeight)
        addConstraint(heightConstraint)

        setNeedsLayout()
    }
}
