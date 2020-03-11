//
//  LargeTextField.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-11.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class LargeTextField: UITextField {
    
    // MARK: Properties
    
    private let animationDuration = 0.3
    
    private let textFieldHeight = CGFloat(46)
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .sunglassDarkGrey
        label.font = .sunglassRegularFont(.small)
        let inset = CGFloat(7)
        label.frame.size.height = 15
        label.frame.size.width = 200
        label.frame.origin.x = inset
        return label
    }()

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
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        insertSubview(descriptionLabel, at: 0)
    }
    
    // MARK: View
    
    private func setup() {
        delegate = self
        textColor = UIColor.sunglassDarkGrey
        tintColor = UIColor.sunglassDarkGrey
        font = UIFont.sunglassRegularFont(.medium)
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: textFieldHeight)
        addConstraint(heightConstraint)
    }
    
    func setDescriptionLabel(to text: String) {
        descriptionLabel.text = text
    }
    
    func showLabel() {
        UIView.animate(withDuration: animationDuration) {
            self.descriptionLabel.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(-15))
        }
    }
    
    func hideLabel() {
        UIView.animate(withDuration: animationDuration) {
            self.descriptionLabel.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(0))
        }
    }
}

// MARK: UITextFieldDelegate

extension LargeTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showLabel()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let text = textField.text, text == "" {
            hideLabel()
        }
    }
}
