//
//  Order.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-01.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

struct Order {
    let id: String
    let items: [(productItem: ProductItem, quantity: quantity)]
    
    init(_ items: [(productItem: ProductItem, quantity: quantity)]) {
        self.id = UUID().uuidString
        self.items = items
    }
}
