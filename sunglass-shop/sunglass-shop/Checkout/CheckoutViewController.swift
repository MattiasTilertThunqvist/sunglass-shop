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
    private let cart = ProductList(items: [
        ProductItem(id: "Ett", title: "Rayban", price: 59, description: "Text!", imageUrlString: "url"),
        ProductItem(id: "Två", title: "Persol", price: 159, description: "Text!", imageUrlString: "url")
    ])
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productsContainer: ContainerView!
    @IBOutlet weak var nameTextField: LargeTextField!
    @IBOutlet weak var emailTextField: LargeTextField!
    @IBOutlet weak var phoneNumberTextField: LargeTextField!
    @IBOutlet weak var addressTextField: LargeTextField!
    @IBOutlet weak var optionalAddressTextField: LargeTextField!
    @IBOutlet weak var cityTextField: LargeTextField!
    @IBOutlet weak var postCodeTextField: LargeTextField!
    @IBOutlet weak var countyTextField: LargeTextField!
    @IBOutlet weak var orderButton: LargeButton!
    
    // MARK: IBActions
    
    @IBAction func orderButtonPressed(_ sender: LargeButton) {
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
    
    private func setup() {
        nameTextField.setDescriptionLabel(to: "NAME")
        emailTextField.setDescriptionLabel(to: "EMAIL")
        phoneNumberTextField.setDescriptionLabel(to: "PHONE NUMBER")
        addressTextField.setDescriptionLabel(to: "ADDRESS")
        cityTextField.setDescriptionLabel(to: "CITY")
        postCodeTextField.setDescriptionLabel(to: "POSTCODE")
        countyTextField.setDescriptionLabel(to: "COUNTRY")
        
        orderButton.colorScheme = .goldOnBlack
    }
    
    // MARK: Handlers
    
    private func handleOrderButtonPress() {
        let viewController = StoryboardInstance.ordersViewController()
        present(viewController, animated: true, completion: nil)
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
        
        return cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.cellIdentifier, for: indexPath) as! CartTableViewCell
        return cell
    }
}

extension CheckoutViewController: UITableViewDelegate {
     
}
