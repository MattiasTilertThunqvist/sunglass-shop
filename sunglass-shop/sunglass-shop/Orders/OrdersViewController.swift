//
//  OrdersViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-12.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    // MARK: Properties
    
    var orders: [Order] = []
    private let cellIdentifier = CartTableViewCell.cellIdentifier
    private var orderInfoViewController: OrderInfoViewController?
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var productsTableView: UITableView!
    
    // MARK: IBActions
    
    @IBAction private func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setup()
    }
    
    private func setup() {
        getOrders()
    }
        
    private func getOrders() {
        NetworkManager.shared.getOrders() { (orders, error) in
            // TODO: If there's another error then display it.
            self.orders = orders ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellIdentifier, for: indexPath) as! CartTableViewCell
        let (productItem, quantity) = orders[indexPath.section].items[indexPath.row]
        
        cell.setProductImage(to: productItem.imageUrlString)
        cell.setBrandLabel(to: productItem.brand)
        cell.setModelLabel(to: productItem.brand)
        cell.setPriceAndQuantity(pricePerItem: productItem.price, quantity)
        cell.removeButtonIsHidden = true
        cell.changeQuantityButtonsIsHidden = true
        return cell
    }
}

extension OrdersViewController: UITableViewDelegate {
     
}

