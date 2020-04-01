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
    @IBOutlet weak private var nameTextField: LargeTextField!
    @IBOutlet weak private var emailTextField: LargeTextField!
    @IBOutlet weak private var phoneNumberTextField: LargeTextField!
    @IBOutlet weak private var addressTextField: LargeTextField!
    @IBOutlet weak private var optionalAddressTextField: LargeTextField!
    @IBOutlet weak private var cityTextField: LargeTextField!
    @IBOutlet weak private var postCodeTextField: LargeTextField!
    @IBOutlet weak private var countyTextField: LargeTextField!
    @IBOutlet weak private var orderButton: LargeButton!
    
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
    
    private func setup() {
        title = "CHECKOUT"
        
        if Cart.shared.countItems() == 0 {
            displayCartAsEmpy()
            return
        } else {
            setTotalPrice()
        }
        
        setupTextFields()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Handlers
    
    private func handleOrderButtonPress() {
        guard let user = getUser() else { return } // TODO: Manage empty object
        let items = Cart.shared.getItems()
        let order = Order(items, user)
        
        let viewController = StoryboardInstance.ordersViewController()
        viewController.order = order
        present(viewController, animated: true, completion: nil)
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


// MARK: Manage textfields

extension CheckoutViewController {
    
    // MARK: IBActions
    
    @IBAction private func namePrimaryActionTriggered(_ sender: LargeTextField) {
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction private func nameDidEndEditing(_ sender: LargeTextField) {
        // MARK: TODO: Proper validation
        let isValid = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        nameTextField.inputIsValid = isValid
    }
    
    @IBAction private func emailPrimaryActionTriggered(_ sender: LargeTextField) {
        phoneNumberTextField.becomeFirstResponder()
    }
    
    @IBAction private func emailDidEndEditing(_ sender: LargeTextField) {
        // MARK: TODO: Implement proper validation
        let isValid = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        emailTextField.inputIsValid = isValid
    }
    
    @IBAction private func phoneNumberPrimaryActionTriggered(_ sender: LargeTextField) {
        addressTextField.becomeFirstResponder()
    }
    
    @IBAction private func phoneNumberDidEndEditing(_ sender: LargeTextField) {
        // MARK: TODO: Implement proper validation
        let isValid = phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        phoneNumberTextField.inputIsValid = isValid
    }
        
    @IBAction private func addressPrimaryActionTriggered(_ sender: LargeTextField) {
        optionalAddressTextField.becomeFirstResponder()
    }
    
    @IBAction private func addressDidEndEditing(_ sender: LargeTextField) {
        // MARK: TODO: Implement proper validation
        let isValid = addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        addressTextField.inputIsValid = isValid
    }

    @IBAction private func optionalAddressPrimaryActionTriggered(_ sender: LargeTextField) {
        cityTextField.becomeFirstResponder()
    }
    
    @IBAction private func cityPrimaryActionTriggered(_ sender: LargeTextField) {
        postCodeTextField.becomeFirstResponder()
    }
    
    @IBAction private func cityDidEndEditing(_ sender: LargeTextField) {
        // MARK: TODO: Implement proper validation
        let isValid = cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        cityTextField.inputIsValid = isValid
    }
    
    @IBAction private func postcodePrimaryActionTriggered(_ sender: LargeTextField) {
        countyTextField.becomeFirstResponder()
    }
    
    @IBAction private func postcodeDidEndEditing(_ sender: LargeTextField) {
        // MARK: TODO: Implement proper validation
        let isValid = postCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        postCodeTextField.inputIsValid = isValid
    }
    
    @IBAction private func countryPrimaryActionTriggered(_ sender: LargeTextField) {
        countyTextField.resignFirstResponder()
    }
    
    @IBAction private func countryDidEndEditing(_ sender: LargeTextField) {
        // MARK: TODO: Implement proper validation
        let isValid = countyTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        countyTextField.inputIsValid = isValid
    }
    
    private func setupTextFields() {
        nameTextField.setDescriptionLabel(to: "NAME")
        emailTextField.setDescriptionLabel(to: "EMAIL")
        phoneNumberTextField.setDescriptionLabel(to: "PHONE NUMBER")
        addressTextField.setDescriptionLabel(to: "ADDRESS")
        cityTextField.setDescriptionLabel(to: "CITY")
        postCodeTextField.setDescriptionLabel(to: "POSTCODE")
        countyTextField.setDescriptionLabel(to: "COUNTRY")
        orderButton.colorScheme = .goldOnBlack
    }
    
    func getUser() -> User? {
        guard let name = nameTextField.text, name != "" else {
            nameTextField.inputIsValid = false
            nameTextField.becomeFirstResponder()
            return nil
        }
        
        guard let email = emailTextField.text, email != "" else {
            emailTextField.inputIsValid = false
            emailTextField.becomeFirstResponder()
            return nil
        }
        
        guard let phoneNumber = phoneNumberTextField.text, phoneNumber != "" else {
            phoneNumberTextField.inputIsValid = false
            phoneNumberTextField.becomeFirstResponder()
            return nil
        }
        
        guard let address = addressTextField.text, address != "" else {
            addressTextField.inputIsValid = false
            addressTextField.becomeFirstResponder()
            return nil
        }
        
        let optional = optionalAddressTextField.text
        
        guard let city = cityTextField.text, city != "" else {
            cityTextField.inputIsValid = false
            cityTextField.becomeFirstResponder()
            return nil
        }
        
        guard let postCode = postCodeTextField.text, postCode != "" else {
            postCodeTextField.inputIsValid = false
            postCodeTextField.becomeFirstResponder()
            return nil
        }
        
        guard let country = countyTextField.text, country != "" else {
            countyTextField.inputIsValid = false
            countyTextField.becomeFirstResponder()
            return nil
        }
        
        return User(name, email, phoneNumber, address, optional, city, postCode, country)
    }
}
