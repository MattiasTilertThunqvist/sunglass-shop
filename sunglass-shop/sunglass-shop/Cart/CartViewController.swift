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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: LargeButton!
    
    
    // MARK: IBActions
    
    @IBAction func checkoutButtonPressed(_ sender: LargeButton) {
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
    }
    
    private func handleCheckoutButtonPress() {
        let viewController = StoryboardInstance.checkoutViewController()
        navigationController?.pushViewController(viewController, animated: true)
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
        
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    
    
}


