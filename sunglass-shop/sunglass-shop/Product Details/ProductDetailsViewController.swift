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
    
    @IBOutlet weak private var productImageView: CustomImageView!
    @IBOutlet weak private var productTitleLabel: LargeTextLabel!
    @IBOutlet weak private var priceLabel: MediumTextLabel!
    @IBOutlet weak private var findInStoreButton: SmallButton!
    @IBOutlet weak private var tryItOnButton: SmallButton!
    @IBOutlet weak private var addToCartButton: LargeButton!
    
    // MARK: IBActions
    
    @IBAction func didTapFindInStoreButton(_ sender: SmallButton) {
        handleFindInStoreButtonPress()
    }
    
    @IBAction func didTapTryItOnButton(_ sender: SmallButton) {
        handleTryItOnButtonPress()
    }
    
    @IBAction func didTapAddToCartButton(_ sender: LargeButton) {
        handleAddToCartButtonPress()
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping-bag"), style: .plain, target: self, action: #selector(handleGoToCartButtonPress))
        
        findInStoreButton.colorScheme = .blackOnTransparent        
        tryItOnButton.colorScheme = .whiteOnBlack
        addToCartButton.colorScheme = .goldOnBlack
        
        productTitleLabel.text = "RAYBAN"
        priceLabel.text = "Price: £69"
    }
    
    // MARK: Handle events
    
    @objc private func handleGoToCartButtonPress() {
        let viewController = StoryboardInstance.cartViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handleFindInStoreButtonPress() {
        let viewController = StoryboardInstance.storesOnMapViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handleTryItOnButtonPress() {
        let viewController = StoryboardInstance.tryProductViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handleAddToCartButtonPress() {
        
    }
}
