//
//  OrderDetailsHeaderTableViewCell.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-09.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class OrderDetailsHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: Properties
    
    static let identifier = "OrderDetailsHeaderFooterView"
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var orderIdLabel: LargeTextLabel!
    @IBOutlet weak private var orderDateLabel: LargeTextLabel!
    @IBOutlet weak private var grandTotalLabel: LargeTextLabel!
    
    // MARK: Accessors
    
    func setOrderId(to text: String) {
        orderIdLabel.text = text
    }
    
    func setOrderDateLabel(to date: Date) {
        orderDateLabel.text = "\(date)"
    }
    
    func setGrandTotalLabel(to text: String) {
        grandTotalLabel.text = text
    }
}
