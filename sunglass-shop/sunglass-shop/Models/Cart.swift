//
//  Cart.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-23.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

class Cart {
    
    // MARK: Properties
    
    static let shared = Cart()
    
    typealias productId = String
    private var items: [productId] = []
    private var quantity: [Int] = []
    
    // MARK: Init
    
    private init() {
        self.items = ["12dd34", "12dd345"]
        self.quantity = [1, 1]
    }
    
    // MARK: Accessors
    
    func countItems() -> Int {
        return items.count
    }
    
    
}
