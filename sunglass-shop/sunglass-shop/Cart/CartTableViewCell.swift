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
    @IBOutlet weak private var decreaseButton: MiniButton!
    @IBOutlet weak private var increase: MiniButton!
    @IBOutlet weak private var quantityLabel: MediumTextLabel!
    
    // MARK:IBActions
    
    @IBAction private func didTapRemoveButton(_ sender: UIButton) {
        cartTableViewCellDelegate.cartTableViewCell(removeProductWith: productItemId)
    }
    
    @IBAction private func didTapIncreaseButton(_ sender: MiniButton) {
        cartTableViewCellDelegate.cartTableViewCell(.increaseQuantity, for: productItemId)
    }
    
    @IBAction private func didTapDecreaseButton(_ sender: MiniButton) {
        cartTableViewCellDelegate.cartTableViewCell(.decreaseQuantity, for: productItemId)
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
        priceLabel.text = "\(quantitiy) x £\(totalPrice)"
        quantityLabel.text = "\(quantitiy)"
    }
}

enum ChangeQuantity {
    case increaseQuantity, decreaseQuantity
}

protocol CartTableViewCellDelegate: AnyObject{
    func cartTableViewCell(_ changeQuantity: ChangeQuantity, for productItemId: String)
    func cartTableViewCell(removeProductWith productItemId: String)
}
