//
//  NetworkManager.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-24.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage  

class NetworkManager {
    
    // MARK: Properties
    
    static let shared = NetworkManager()
    static let storage = Storage.storage()
    private let productsRef = Firestore.firestore().collection("products")
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Networking
    
    func getProducts(then handler: @escaping (Error?) -> ()) {
        productsRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying productItems from Firestore: \(error)")
                handler(error)
            }
            
            let result = Result {
                try querySnapshot?.documents.compactMap {
                    try $0.data(as: ProductItem.self)
                }
            }
            
            switch result {
            case .success(let productItems):
                if let productItems = productItems {
                    ProductList.shared.addItems(productItems)
                    handler(nil)
                } else {
                    print("Documents does not exist")
                    handler(NetworkError.noDocument)
                }
            case .failure(let error):
                print("Error decoding productItem: \(error)")
                handler(error)
            }
        }
    }
}
