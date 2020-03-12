//
//  OrdersViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-12.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    // MARK: Propterties
    
    private let cellIdentifier = CartTableViewCell.cellIdentifier
    private let cart = ProductList(items: [
        ProductItem(id: "Ett", title: "Rayban", price: 59, description: "Text!", imageUrlString: "url"),
        ProductItem(id: "Två", title: "Persol", price: 159, description: "Text!", imageUrlString: "url")
    ])
    
    // MARK: IBOutlets
    
    @IBOutlet weak var productsContainer: ContainerView!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var productsTableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: IBActions
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        productsTableViewHeightConstraint.constant = productsTableView.contentSize.height
        productsContainer.sizeToFit()
    }
}

// MARK: TableView

extension OrdersViewController {
    
    private func setupTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.rowHeight = UITableView.automaticDimension
        productsTableView.estimatedRowHeight = 120
        registerNib()
    }
    
    private func registerNib() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        productsTableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}

extension OrdersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellIdentifier, for: indexPath) as! CartTableViewCell
        return cell
    }
}

extension OrdersViewController: UITableViewDelegate {
     
}

