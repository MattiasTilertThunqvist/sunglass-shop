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
    
    var orders: [Order]?
    var user: User?
    private let cellIdentifier = CartTableViewCell.cellIdentifier
    private var orderInfoViewController: OrderInfoViewController?
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var orderInfoContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var productsContainer: ContainerView!
    @IBOutlet weak private var productsTableView: UITableView!
    @IBOutlet weak private var productsTableViewHeightConstraint: NSLayoutConstraint!
    
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
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        productsTableViewHeightConstraint.constant = productsTableView.contentSize.height
        productsContainer.sizeToFit()
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if let orderInfoContainer = container as? OrderInfoViewController {
            orderInfoContainerHeightConstraint.constant = orderInfoContainer.preferredContentSize.height
        }
    }
    
    private func setup() {
        contentView.isHidden = true // Hidden by default
        
        if let orderInfoViewController = children.first as? OrderInfoViewController {
            self.orderInfoViewController = orderInfoViewController
        } else {
            fatalError("Check storyboard for missing OrderInfoViewController")
        }
        
        if user == nil {
            getUser()
        }
        
        getOrders()
    }
    
    private func getUser() {
        NetworkManager.shared.getUser { (user, error) in
            // TODO: If there's another error then display it
            
            guard let user = user else { return }
            
            DispatchQueue.main.async {
                self.user = user
                self.orderInfoViewController?.user = user
                self.contentView.isHidden = false
            }
        }
    }
    
    private func getOrders() {
        NetworkManager.shared.getOrders() { (orders, error) in
            // TODO: If there's another error then display it.
            
            self.orders = orders
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Cart.shared.countItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellIdentifier, for: indexPath) as! CartTableViewCell
        return cell
    }
}

extension OrdersViewController: UITableViewDelegate {
     
}

