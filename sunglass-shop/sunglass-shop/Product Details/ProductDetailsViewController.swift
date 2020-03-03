//
//  ProductDetailsViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-03.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    var productItem: ProductItem!
    
    // MARK: IBOutlets
    
    @IBOutlet weak var findInStoreButton: SmallButton!
    @IBOutlet weak var tryItOnButton: SmallButton!
    
    
    // MARK: IBActions
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
    private func setup() {
        
        
        findInStoreButton.colorScheme = .grayOnTransparent
        findInStoreButton.setTitle("Find in store", for: .normal)
        
        tryItOnButton.colorScheme = .whiteOnGray
        tryItOnButton.setTitle("Try it on", for: .normal)
    }
}
