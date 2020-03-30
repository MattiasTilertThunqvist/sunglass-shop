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
    
    private let cellIdentifier = CartTableViewCell.cellIdentifier
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var totalPriceDescriptionLabel: LargeTextLabel!
    @IBOutlet weak private var totalPriceLabel: LargeTextLabel!
    @IBOutlet weak private var checkoutButton: LargeButton!
    
    // MARK: IBActions
    
    @IBAction private func checkoutButtonPressed(_ sender: LargeButton) {
        handleCheckoutButtonPress()
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    private func setup() {
        checkoutButton.colorScheme = .goldOnBlack
        setTotalPrice()
        
        if Cart.shared.countItems() == 0 {
            setCartAsEmpy()
        }
    }
    
    private func handleCheckoutButtonPress() {
        let viewController = StoryboardInstance.checkoutViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: Helpers
    
    private func setTotalPrice() {
        totalPriceLabel.text = "£\(Cart.shared.getTotalPrice())"
    }
    
    private func setCartAsEmpy() {
        let emptyCartlabel = LargeTextLabel()
        emptyCartlabel.numberOfLines = 10
        emptyCartlabel.textAlignment = .center
        emptyCartlabel.text = "Cart is empty. Please return to product page and att items."
        emptyCartlabel.frame = view.frame
        view.addSubview(emptyCartlabel)
        
        totalPriceDescriptionLabel.isHidden = true
        totalPriceLabel.isHidden = true
        checkoutButton.isHidden = true
    }
}

// MARK: TableView

extension CartViewController: UITableViewDataSource {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        registerCell()
        tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.countItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell
        let (productItem, quantity) = Cart.shared.getItem(withIndex: indexPath.row)
        
        cell.setProductImage(to: productItem.imageUrlString)
        cell.setBrandLabel(to: productItem.brand)
        cell.setModelLabel(to: productItem.model)
        cell.setPriceAndQuantity(pricePerItem: productItem.price, quantity)
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    
}


