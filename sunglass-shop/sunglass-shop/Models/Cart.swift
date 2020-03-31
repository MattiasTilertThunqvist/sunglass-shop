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
    
    func add(_ productItem: ProductItem) {
        // If item is already in cart, quantity is updated
        if let index = items.firstIndex(where: { $0.productItem.id == productItem.id }) {
            items[index].quantity += 1
            return
        }
        
        let defaultQuantity = 1
        let cartItem = CartItem(productItem: productItem, quantity: defaultQuantity)
        items.append(cartItem)
    }
    
    func changeQuantity(for productItem: ProductItem, _ changeQuantity: ChangeQuantity) {
        switch changeQuantity {
        case .increaseQuantity:
            add(productItem)
        case .decreaseQuantity:
            if let index = items.firstIndex(where: { $0.productItem.id == productItem.id }) {
                // Quantity can't be lower than 1
                if items[index].quantity > 1 {
                    items[index].quantity -= 1
                }
            }
        }
    }
    
//    func remove(_ productItem: ProductItem) {
//
//    }
    
    func getItem(withIndex index: Int) -> (ProductItem, quantity) {
        let item = items[index]
        return (item.productItem, item.quantity)
    }
    
    func countItems() -> Int {
        return items.count
    }
    
    func getTotalPrice() -> Double {
        var totalPrice: Double = 0
        items.forEach({ totalPrice += $0.productItem.price * Double($0.quantity) })
        return totalPrice
    }
}
