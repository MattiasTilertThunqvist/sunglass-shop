//
//  ContainerView.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-11.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    // MARK: Init
    
    public init() {
        super.init(frame: .zero)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setup()
    }

    // MARK:  View
    
    private func setup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
    }
}
