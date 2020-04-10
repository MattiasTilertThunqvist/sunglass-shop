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
    private var quantity: Int = 1 
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var productImageView: CustomImageView!
    @IBOutlet weak private var productTitleLabel: LargeTextLabel!
    @IBOutlet weak private var priceLabel: MediumTextLabel!
    @IBOutlet weak private var findInStoreButton: SmallButton!
    @IBOutlet weak private var tryItOnButton: SmallButton!
    @IBOutlet weak private var productDescriptionLabel: MediumTextLabel!
    @IBOutlet weak private var addToCartButton: LargeButton!
    
    // MARK: IBActions
    
    @IBAction private func didTapFindInStoreButton(_ sender: SmallButton) {
        handleFindInStoreButtonPress()
    }
    
    @IBAction private func didTapTryItOnButton(_ sender: SmallButton) {
        handleTryItOnButtonPress()
    }
    
    @IBAction private func didTapAddToCartButton(_ sender: LargeButton) {
        handleAddToCartButtonPress()
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping-cart"), style: .plain, target: self, action: #selector(handleGoToCartButtonPress))
        
        findInStoreButton.colorScheme = .blackOnTransparent
        tryItOnButton.colorScheme = .whiteOnBlack
        addToCartButton.colorScheme = .goldOnBlack
        
        productImageView.setImage(from: productItem.imageUrlString)
        productTitleLabel.text = "\(productItem.brand) \(productItem.model)"
        priceLabel.text = String(format: "Price: £%.f", productItem.price)
        productDescriptionLabel.text = productItem.description
    }
    
    // MARK: Handle events
    
    @objc private func handleGoToCartButtonPress() {
        let viewController = StoryboardInstance.checkoutViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handleFindInStoreButtonPress() {
        let viewController = StoryboardInstance.storesOnMapViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handleTryItOnButtonPress() {
        let viewController = StoryboardInstance.tryProductViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handleAddToCartButtonPress() {
        Cart.shared.add(productItem)
    }
}
