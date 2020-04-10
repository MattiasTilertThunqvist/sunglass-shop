//
//  OrderDetailsHeaderFooterView.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-10.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

class OrderDetailsHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: Properties
    
    static let identifier = "OrderDetailsHeaderFooterView"
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var orderIdLabel: MediumTextLabel!
    @IBOutlet weak private var orderDateLabel: MediumTextLabel!
    @IBOutlet weak private var totalNrProductsLabel: MediumTextLabel!
    @IBOutlet weak private var grandTotalLabel: ExtraLargeTextLabel!
    
    // MARK: Accessors
    
    func setOrderId(to text: String) {
        orderIdLabel.text = "Nº: \(text)".uppercased()
    }
    
    func setOrderDateLabel(to date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        orderDateLabel.text = dateFormatter.string(from: date)

    }
    
    func setTotalNrOfproduct(to value: Int) {
        let ending = value == 1 ? "PRODUCT" : "PRODUCTS"
        totalNrProductsLabel.text = "TOTAL: \(value) \(ending)".uppercased()
    }
    
    func setGrandTotalLabel(to value: Double) {
        grandTotalLabel.text = String(format: "£%.f", value)
    }
}
