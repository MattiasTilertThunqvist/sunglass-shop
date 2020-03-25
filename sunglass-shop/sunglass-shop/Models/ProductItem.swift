//
//  ProductItem.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-02.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

struct ProductItem: Codable {
    
    enum OfferType: String, Codable {
        case promo
        case regular
    }
    
    let id: String
    let brand: String
    let model: String
    let price: Double
    let description: String
    let imageUrlString: String
    let offerType: OfferType
    let promoHeaderTitle: String?
    let promoImageUrlString: String?
    let rank: Int
}
