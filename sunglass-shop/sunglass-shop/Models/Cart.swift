//
//  Cart.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-23.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

typealias productId = String
typealias quantity = Int

class Cart {
    
    struct CartItem {
        var productItem: ProductItem
        var quantity: quantity
    }
    
    // MARK: Properties
    
    static let shared = Cart()
    
    private var items: [CartItem] = []
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Accessors
    
    func addProduct(with productItem: ProductItem, _ quantity: quantity) {
        // If item is already in cart, quantity is updated
        if let index = items.firstIndex(where: { $0.productItem.id == productItem.id }) {
            items[index].quantity = quantity
            return
        }
        
        let cartItem = CartItem(productItem: productItem, quantity: quantity)
        items.append(cartItem)
    }
    
    
    func getItem(withIndex index: Int) -> (ProductItem, quantity) {
        let item = items[index]
        return (item.productItem, item.quantity)
    }
    
    func countItems() -> Int {
        return items.count
    }
    
    func getTotalPrice() -> Double {
        var totalPrice: Double = 0
        items.forEach({ totalPrice += $0.productItem.price })
        return totalPrice
    }
}
