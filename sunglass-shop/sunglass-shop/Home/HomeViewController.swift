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
    
    private let productList = ProductList(items: [ProductItem(title: "Rayban", price: 59),
                                            ProductItem(title: "Persol", price: 159),
                                            ProductItem(title: "Gucci", price: 59),
                                            ProductItem(title: "Prada", price: 59),
                                            ProductItem(title: "Lacoste", price: 59),
                                            ProductItem(title: "Brallor", price: 59)])
    private let cellIdentifier = HomeCollectionViewCell.cellIdentifier
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
    }

    private func setup() {
        
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



