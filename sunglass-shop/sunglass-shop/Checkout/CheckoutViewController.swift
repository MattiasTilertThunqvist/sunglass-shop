//
//  CheckoutViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-11.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: Properties
    
    private let cellIdentifier = CartTableViewCell.cellIdentifier
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var totalPriceLabel: LargeTextLabel!
    @IBOutlet weak private var productsContainer: ContainerView!
    @IBOutlet weak private var textfieldsContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var orderButton: LargeButton!
    
    private var checkoutTextfieldsViewController: CheckoutTextfieldsViewController?
    
    // MARK: IBActions
    
    @IBAction private func orderButtonPressed(_ sender: LargeButton) {
        handleOrderButtonPress()
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        tableViewHeightConstraint.constant = tableView.contentSize.height
        productsContainer.sizeToFit()
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if let checkoutTextfieldsViewController = container as? CheckoutTextfieldsViewController {
            textfieldsContainerHeightConstraint.constant = checkoutTextfieldsViewController.preferredContentSize.height
        }
    }
    
    private func setup() {
        title = "CHECKOUT"
        
        if Cart.shared.countItems() == 0 {
            displayCartAsEmpy()
            return
        } else {
            setTotalPrice()
            orderButton.colorScheme = .goldOnBlack
        }
        
        guard let checkoutTextfieldsViewController = children.first as? CheckoutTextfieldsViewController else {
            fatalError("Storyboard is missing CheckoutTextfieldsViewController")
        }
        
        self.checkoutTextfieldsViewController = checkoutTextfieldsViewController
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Handlers
    
    private func handleOrderButtonPress() {
        let newOrder = Order(nil, nil, Cart.shared.getItems())
        guard let user = checkoutTextfieldsViewController?.getUser() else { return }
        
        NetworkManager.shared.placeNewOrder(newOrder, user) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Couldn't place order", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            } else {
                let viewController = StoryboardInstance.ordersViewController()
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Helpers
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        scrollView.contentInset.bottom = keyboardFrame.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
    
    private func setTotalPrice() {
        self.totalPriceLabel.text = String(format: "£%.f", Cart.shared.getTotalPrice())
    }
    
    private func displayCartAsEmpy() {
        contentView.isHidden = true

        let emptyCartlabel = LargeTextLabel()
        emptyCartlabel.numberOfLines = 10
        emptyCartlabel.textAlignment = .center
        emptyCartlabel.text = "Cart is empty. Please return to product page and add items."
        emptyCartlabel.frame = view.frame
        view.addSubview(emptyCartlabel)
    }
}

// MARK: TableView

extension CheckoutViewController {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        registerNib()
    }
    
    private func registerNib() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}

extension CheckoutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.countItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellIdentifier, for: indexPath) as! CartTableViewCell
        let (productItem, quantity) = Cart.shared.getItem(withIndex: indexPath.row)
        cell.productItemId = productItem.id
        cell.cartTableViewCellDelegate = self
        cell.setProductImage(to: productItem.imageUrlString)
        cell.setModelLabel(to: productItem.model)
        cell.setBrandLabel(to: productItem.brand)
        cell.setPriceAndQuantity(pricePerItem: productItem.price, quantity)
        return cell
    }
}

extension CheckoutViewController: UITableViewDelegate {
     
}

extension CheckoutViewController: CartTableViewCellDelegate {
    
    func cartTableViewCell(_ editQuantity: EditQuantity, _ productItemId: productItemId) {
        let productItem = ProductList.shared.getItem(with: productItemId)
        Cart.shared.changeQuantity(for: productItem, editQuantity)
        tableView.reloadData()
        setTotalPrice()
        
        if Cart.shared.isEmpty() {
            displayCartAsEmpy()
        }
    }
}
