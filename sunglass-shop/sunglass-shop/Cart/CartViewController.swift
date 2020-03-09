//
//  AddToCartViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-04.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: Properties
    
    private let cart = ProductList(items: [
        ProductItem(id: "Ett", title: "Rayban", price: 59, description: "Text!", imageUrlString: "url"),
        ProductItem(id: "Två", title: "Persol", price: 159, description: "Text!", imageUrlString: "url")
    ])
    
    private let cellIdentifier = CartTableViewCell.cellIdentifier
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    private func setup() {
        
    }
}

// MARK: TableView

extension CartViewController: UITableViewDataSource {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell
        
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    
    
}


