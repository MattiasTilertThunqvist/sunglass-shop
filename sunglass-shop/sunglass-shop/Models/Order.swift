//
//  Order.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-01.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

struct Order {
    let items: [(productItem: ProductItem, quantity: quantity)]
    let user: User
    
    init(_ items: [(productItem: ProductItem, quantity: quantity)], _ user: User) {
        self.items = items
        self.user = user
    }
}
