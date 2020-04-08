//
//  Order.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-01.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

class Order {
    
    // MARK: Properties
    
    let id: String
    let date: Date
    let items: [(productItem: ProductItem, quantity: quantity)]
    
    // MARK: Init
    
    init(_ id: String?, _ date: Date?, _ items: [(productItem: ProductItem, quantity: quantity)]) {
        self.id = id ?? UUID().uuidString
        self.date = date ?? Date()
        self.items = items
    }
}


