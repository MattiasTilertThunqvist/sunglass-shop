//
//  User.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-04-01.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let phoneNumber: String
    let address: String
    let optional: String?
    let city: String
    let postCode: String
    let country: String
    typealias orderId = String
    var order: [orderId] = []
    
    init(_ id: String, _ name: String, _ email: String, _ phoneNumber: String, _ address: String, _ optional: String?, _ city: String, _ postCode: String, _ country: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
        self.optional = optional
        self.city = city
        self.postCode = postCode
        self.country = country
    }
}
