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
    
    // MARK: IBoutlets
    
    @IBOutlet weak var removeButton: MiniButton!
    @IBOutlet weak var addButton: MiniButton!
    @IBOutlet weak var quantityLabel: MediumTextLabel!
    
    // MARK:IBActions
    
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        removeButton.colorScheme = .blackOnTransparent
        addButton.colorScheme = .blackOnTransparent
    }
    
    
}

