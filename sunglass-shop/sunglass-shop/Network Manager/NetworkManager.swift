//
//  NetworkManager.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation
import FirebaseFirestore

class NetworkManager {
    
    // MARK: Properties
    
    static let shared = NetworkManager()
    private let productsRef = Firestore.firestore().collection("products")
    
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Networking
    
    func getProducts() {
        productsRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                // Handle error
                print()
            }
            
            for document in querySnapshot!.documents {
                print(document)
            }
        
        }
    }
}
