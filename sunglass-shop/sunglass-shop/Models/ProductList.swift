//
//  ProductList.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

class ProductList {
    
    // MARK: Properties
    
    static let shared = ProductList()
    private var items: [ProductItem] = []
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Accessors
    
    func countItems() -> Int {
        return items.count
    }
    
    func itemAtIndex(_ index: Int) -> ProductItem {
        return items[index]
    }
    
    func getAllItems() -> [ProductItem] {
        return items
    }
    
    func addItems(_ productItems: [ProductItem]) {
        self.items = productItems
        sortItemsByRank()
    }
    
    // MARK: Support
    
    private func sortItemsByRank() {
        items.sort { $0.rank < $1.rank }
    }
}
