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
    @IBOutlet weak var addToCartButton: LargeButton!
    
    // MARK: IBActions
    
    @IBAction func findInStoreButtonPressed(_ sender: SmallButton) {
        handleFindInStoreButtonPress()
    }
    
    @IBAction func tryItOnButtonPressed(_ sender: SmallButton) {
        handleTryItOnButtonPress()
    }
    
    @IBAction func addToCartButtonPressed(_ sender: LargeButton) {
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
        findInStoreButton.setTitle("Find in store", for: .normal)
        
        tryItOnButton.colorScheme = .whiteOnBlack
        tryItOnButton.setTitle("Try it on", for: .normal)
        
        addToCartButton.colorScheme = .whiteOnBlack
        addToCartButton.setTitle("Add to cart", for: .normal)
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
