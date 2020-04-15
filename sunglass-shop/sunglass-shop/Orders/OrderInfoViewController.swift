//
//  OrderInfoViewController.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-06.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class OrderInfoViewController: UIViewController {
    
    // MARK: Properties
    
    private var user: User?
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var nameLabel: LargeTextLabel!
    @IBOutlet private weak var emailLabel: LargeTextLabel!
    @IBOutlet private weak var phoneNumberLabel: LargeTextLabel!
    @IBOutlet private weak var addressLabel: LargeTextLabel!
    @IBOutlet private weak var optionalLabel: LargeTextLabel!
    @IBOutlet private weak var cityLabel: LargeTextLabel!
    @IBOutlet private weak var postCodeLabel: LargeTextLabel!
    @IBOutlet private weak var countryLabel: LargeTextLabel!
    
    // MARK: IBActions
    
    @IBAction func didTapDismissButton(_ sender: DismissRoundButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.isHidden = true
    }
    
    private func setup() {
        NetworkManager.shared.getUser { (user, error) in
            if let error = error {
                let alert = UIAlertController(title: "No user found", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            DispatchQueue.main.async {
                self.user = user
                self.setUserContent()
                self.view.isHidden = false
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }
    
    private func setUserContent() {
        guard let user = user else { return }
        
        self.nameLabel.text = user.name
        self.emailLabel.text = user.email
        self.phoneNumberLabel.text = user.phoneNumber
        self.addressLabel.text = user.address
        self.optionalLabel.text = user.optional
        self.cityLabel.text = user.city
        self.postCodeLabel.text = user.postCode
        self.countryLabel.text = user.country
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
}
