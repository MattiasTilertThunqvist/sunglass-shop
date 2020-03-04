//
//  ViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Properties
    
    private let productList = ProductList(items: [
        ProductItem(id: "Ett", title: "Rayban", price: 59, description: "Text!", imageUrlString: "url"),
        ProductItem(id: "Två", title: "Persol", price: 159, description: "Text!", imageUrlString: "url"),
        ProductItem(id: "Tre", title: "Gucci", price: 69, description: "Text", imageUrlString: "Text"),
        ProductItem(id: "Fyra", title: "Prada", price: 69, description: "Text", imageUrlString: "Text"),
        ProductItem(id: "Fem", title: "Lacoste", price: 69, description: "Text", imageUrlString: "Text")
    ])
    
    private let cellIdentifier = HomeCollectionViewCell.cellIdentifier
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: IBAction
    
    @IBAction func storesButtonPressed(_ sender: UIBarButtonItem) {
        handleStoresButtonPress()
    }
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
    }

    private func setup() {
        
    }
    
    // MARK: Handlers
    
    private func handleStoresButtonPress() {
        let viewController = StoryboardInstance.storesOnMapViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: UICollectionView

extension HomeViewController {
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProductItem = productList.items[indexPath.row]
        let viewController = StoryboardInstance.productDetailsViewController()
        viewController.productItem = selectedProductItem
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.items.count
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productItem = productList.items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.setTitle(to: productItem.title)
        cell.setPrice(to: "£\(productItem.price)")
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.frame.width

        if UIDevice().userInterfaceIdiom == .pad {
            let cellSize = collectionViewWidth / 3
            return CGSize(width: cellSize, height: cellSize)
        } else {
            let cellSize = collectionViewWidth / 2
            return CGSize(width: cellSize, height: cellSize)
        }
    }
}



