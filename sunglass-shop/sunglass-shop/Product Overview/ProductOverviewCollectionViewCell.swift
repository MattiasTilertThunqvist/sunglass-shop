//
//  ProductOverviewCollectionViewCell.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class ProductOverviewCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let cellIdentifier = "ProductOverviewCollectionViewCell"
    
    // MARK: IBOulets
    
    @IBOutlet weak private var imageView: CustomImageView!
    @IBOutlet weak private var brandLabel: MediumTextLabel!
    @IBOutlet weak private var modelLabel: MediumTextLabel!
    @IBOutlet weak private var priceLabel: MediumTextLabel!
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        brandLabel.numberOfLines = 1
        modelLabel.numberOfLines = 1
        priceLabel.numberOfLines = 1
    }
    
    // MARK: Accessers
    
    func setImage(from urlString: urlString) {
        imageView.setImage(from: urlString)
    }
    
    func setBrand(to text: String) {
        brandLabel.text = text.uppercased()
    }
    
    func setModel(to text: String) {
        modelLabel.text = text.uppercased()
    }
    
    func setPrice(to price: Double) {
        priceLabel.text = String(format: "£%.f", price)
    }
}
