//
//  HomeCollectionViewCell.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let cellIdentifier = "HomeCollectionViewCell"
    
    // MARK: IBOulets
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: MediumTextLabel!
    @IBOutlet weak private var priceLabel: MediumTextLabel!
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
    }
    
    // MARK: Helpers
    
    func setImage(to image: UIImage) {
        imageView.image = image
    }
    
    func setTitle(to text: String) {
        titleLabel.text = text.uppercased()
    }
    
    func setPrice(to text: String) {
        priceLabel.text = text
    }
}
