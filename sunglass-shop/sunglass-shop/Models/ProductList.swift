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
    
    private init() {
        self.items = [
            ProductItem(id: "12dd34", title: "Rayban", price: 59, description: "Text", imageUrlString: "url", offerType: .promo, promoHeaderTitle: "The perfect sidekick for sunny occasions", promoImageUrlString: nil),
            ProductItem(id: "12dd345", title: "Persol", price: 3359, description: "Text", imageUrlString: "url", offerType: .regular, promoHeaderTitle: nil, promoImageUrlString: nil),
            ProductItem(id: "12dd346", title: "Gucci", price: 59, description: "Text", imageUrlString: "url", offerType: .regular, promoHeaderTitle: nil, promoImageUrlString: nil),
            ProductItem(id: "12dd347", title: "Prada", price: 159, description: "Text", imageUrlString: "url", offerType: .regular, promoHeaderTitle: nil, promoImageUrlString: nil),
            ProductItem(id: "12dd348", title: "Brallor", price: 59, description: "Text", imageUrlString: "url", offerType: .regular, promoHeaderTitle: nil, promoImageUrlString: nil),
            ProductItem(id: "12dd349", title: "Rayban", price: 59, description: "Text", imageUrlString: "url", offerType: .regular, promoHeaderTitle: nil, promoImageUrlString: nil),
            ProductItem(id: "12dd3410", title: "Rayban", price: 59, description: "Text", imageUrlString: "url", offerType: .regular, promoHeaderTitle: nil, promoImageUrlString: nil)
        ]
    }
    
    // MARK: Accessors
    
    func countItems() -> Int {
        return items.count
    }
    
    func itemAtIndex(_ index: Int) -> ProductItem {
        return items[index]
    }
}
