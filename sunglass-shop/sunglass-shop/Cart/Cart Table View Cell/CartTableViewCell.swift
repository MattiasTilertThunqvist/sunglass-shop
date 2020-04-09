//
//  CartTableViewCell.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-09.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let cellIdentifier = "CartTableViewCell"
    var productItemId: String!
    weak var cartTableViewCellDelegate: CartTableViewCellDelegate!
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var productImageView: CustomImageView!
    @IBOutlet weak private var brandLabel: MediumTextLabel!
    @IBOutlet weak private var modelLabel: MediumTextLabel!
    @IBOutlet weak private var priceLabel: MediumTextLabel!
    @IBOutlet weak private var removeButton: UIButton!
    @IBOutlet weak private var changeQuantityStackView: UIStackView!
    @IBOutlet weak private var decreaseButton: MiniButton!
    @IBOutlet weak private var increase: MiniButton!
    @IBOutlet weak private var quantityLabel: MediumTextLabel!
    
    // MARK:IBActions
    
    @IBAction private func didTapRemoveButton(_ sender: UIButton) {
        cartTableViewCellDelegate.cartTableViewCell(.remove, productItemId)
    }
    
    @IBAction private func didTapIncreaseButton(_ sender: MiniButton) {
        cartTableViewCellDelegate.cartTableViewCell(.increaseQuantity, productItemId)
    }
    
    @IBAction private func didTapDecreaseButton(_ sender: MiniButton) {
        cartTableViewCellDelegate.cartTableViewCell(.decreaseQuantity, productItemId)
    }
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        decreaseButton.colorScheme = .blackOnTransparent
        increase.colorScheme = .blackOnTransparent
    }
    
    // MARK: Accessors
    
    func setProductImage(to urlString: urlString) {
        productImageView.setImage(from: urlString)
    }
    
    func setBrandLabel(to text: String) {
        brandLabel.text = text
    }
    
    func setModelLabel(to text: String) {
        modelLabel.text = text
    }
    
    func setPriceAndQuantity(pricePerItem: Double, _ quantitiy: Int) {
        let totalPrice = pricePerItem * Double(quantitiy)
        priceLabel.text = String(format: "\(quantitiy) x £%.f", totalPrice)
        quantityLabel.text = "\(quantitiy)"
    }
    
    var removeButtonIsHidden = false {
        willSet {
            removeButton.isHidden = newValue
        }
    }
    
    var changeQuantityButtonsIsHidden = false {
        willSet {
            changeQuantityStackView.isHidden = newValue
        }
    }
}

enum EditQuantity {
    case increaseQuantity, decreaseQuantity, remove
}

protocol CartTableViewCellDelegate: AnyObject{
    func cartTableViewCell(_ editQuantity: EditQuantity, _ productItemId: productItemId)
}
