//
//  ViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class ProductOverviewViewController: UIViewController {
    
    // MARK: Properties
        
    private let promoCellIdentifier = PromoCollectionViewCell.cellIdentifier
    private let productOverviewCellIdentifier = ProductOverviewCollectionViewCell.cellIdentifier
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        getProducts()
    }

    private func setup() {
        navigationItem.title = "Sunglasses"
        
        let storesButton = UIBarButtonItem(image: #imageLiteral(resourceName: "pin"), style: .plain, target: self, action: #selector(handleStoresButtonPress))
        navigationItem.leftBarButtonItem = storesButton
    
        let ordersButton = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping-bag"), style: .plain, target: self, action: #selector(handleOrdersButtonPress))
        let cartButton = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping-bag"), style: .plain, target: self, action: #selector(handleCartButtonPress))
        navigationItem.rightBarButtonItems = [cartButton, ordersButton]
    }
    
    private func getProducts() {
        NetworkManager.shared.getProducts { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Couldn't load products", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    // MARK: Handlers
    
    @objc private func handleStoresButtonPress() {
        let viewController = StoryboardInstance.storesOnMapViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func handleOrdersButtonPress() {
        let viewController = StoryboardInstance.ordersViewController()
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func handleCartButtonPress() {
        let viewController = StoryboardInstance.checkoutViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: UICollectionView

extension ProductOverviewViewController {
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
    }
    
    private func registerCells() {
        let promoCellNib = UINib(nibName: promoCellIdentifier, bundle: nil)
        collectionView.register(promoCellNib, forCellWithReuseIdentifier: promoCellIdentifier)
        
        let productOverviewCellNib = UINib(nibName: productOverviewCellIdentifier, bundle: nil)
        collectionView.register(productOverviewCellNib, forCellWithReuseIdentifier: productOverviewCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProductItem = ProductList.shared.itemAtIndex(indexPath.row)
        let viewController = StoryboardInstance.productDetailsViewController()
        viewController.productItem = selectedProductItem
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ProductOverviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductList.shared.countItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productItem = ProductList.shared.itemAtIndex(indexPath.row)
        
        switch productItem.offerType {
        case .promo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: promoCellIdentifier, for: indexPath) as! PromoCollectionViewCell
            cell.setBackgroundImage(to: productItem.promoImageUrlString ?? productItem.imageUrlString)
            cell.setPromoTitle(to: productItem.promoHeaderTitle ?? productItem.model)
            return cell
        case .regular:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productOverviewCellIdentifier, for: indexPath) as! ProductOverviewCollectionViewCell
            cell.setImage(from: productItem.imageUrlString)
            cell.setBrand(to: productItem.brand)
            cell.setModel(to: productItem.model)
            cell.setPrice(to: productItem.price)
            return cell
        }
    }
}

extension ProductOverviewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offerType = ProductList.shared.itemAtIndex(indexPath.row).offerType
        let collectionViewWidth = collectionView.frame.width


        switch offerType {
        case .promo:
            return CGSize(width: collectionViewWidth, height: collectionViewWidth)
        case .regular:
            if UIDevice().userInterfaceIdiom == .pad {
                let cellSize = collectionViewWidth / 3
                return CGSize(width: cellSize, height: cellSize)
            } else {
                let cellSize = collectionViewWidth / 2
                return CGSize(width: cellSize, height: cellSize)
            }
        }
    }
}
