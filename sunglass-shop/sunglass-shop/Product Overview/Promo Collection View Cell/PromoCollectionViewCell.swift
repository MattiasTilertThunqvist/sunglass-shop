//
//  PromoCollectionViewCell.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-16.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let cellIdentifier = "PromoCollectionViewCell"
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var backgroundImageView: CustomImageView!
    @IBOutlet private weak var titleLabel: LargeTextLabel!
    @IBOutlet weak var exploreButton: SmallButton!
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        titleLabel.textColor = .white
        exploreButton.colorScheme = .whiteOnTransparent
        exploreButton.isEnabled = false
    }
    
    // MARK: Accessers
    
    func setPromoTitle(to text: String) {
        titleLabel.text = text.uppercased()
    }
    
    func setBackgroundImage(to urlString: urlString) {
        backgroundImageView.setImage(from: urlString)
    }
}
