//
//  CheckoutTextfieldsViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class CheckoutTextfieldsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var nameTextField: LargeTextField!
    @IBOutlet weak private var emailTextField: LargeTextField!
    @IBOutlet weak private var phoneNumberTextField: LargeTextField!
    @IBOutlet weak private var addressTextField: LargeTextField!
    @IBOutlet weak private var optionalAddressTextField: LargeTextField!
    @IBOutlet weak private var cityTextField: LargeTextField!
    @IBOutlet weak private var postCodeTextField: LargeTextField!
    @IBOutlet weak private var countyTextField: LargeTextField!
    
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
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }
    
    private func setup() {
        nameTextField.setDescriptionLabel(to: "NAME")
        emailTextField.setDescriptionLabel(to: "EMAIL")
        phoneNumberTextField.setDescriptionLabel(to: "PHONE NUMBER")
        addressTextField.setDescriptionLabel(to: "ADDRESS")
        cityTextField.setDescriptionLabel(to: "CITY")
        postCodeTextField.setDescriptionLabel(to: "POSTCODE")
        countyTextField.setDescriptionLabel(to: "COUNTRY")
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize) 
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
        
        return User(mockedUserID, name, email, phoneNumber, address, optional, city, postCode, country)
    }
}
