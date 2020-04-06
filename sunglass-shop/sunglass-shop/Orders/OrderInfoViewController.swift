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
    
    var order: Order?
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var orderIdLabel: LargeTextLabel!
    @IBOutlet private weak var orderDateLabel: LargeTextLabel!
    @IBOutlet private weak var nameLabel: LargeTextLabel!
    @IBOutlet private weak var emailLabel: LargeTextLabel!
    @IBOutlet private weak var phoneNumberLabel: LargeTextLabel!
    @IBOutlet private weak var addressLabel: LargeTextLabel!
    @IBOutlet private weak var optionalLabel: LargeTextLabel!
    @IBOutlet private weak var cityLabel: LargeTextLabel!
    @IBOutlet private weak var postCodeLabel: LargeTextLabel!
    @IBOutlet private weak var countryLabel: LargeTextLabel!
    
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
        
    }
    
    private func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
}
