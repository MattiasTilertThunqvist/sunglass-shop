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
    private let mockedUserID = "00M0L90EHwQaBaCMgXJ0isRhu7i2" // Mocked data, only for demo
    private let productsRef = Firestore.firestore().collection("products")
    private let userRef = Firestore.firestore().collection("users")
    private let orderRef = Firestore.firestore().collection("orders")
    
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
    
    func placeNewOrder(_ order: Order, _ user: User, handler: @escaping (Error?) -> ()) {
        let dispatchGroup = DispatchGroup()
        var anyError: Error?
        
        // Add user
        let result = Result {
            dispatchGroup.enter()
            try userRef.document(user.id).setData(from: user)
        }
        
        switch result {
        case .failure(let error):
            print("Error uploading user: \(error)")
            anyError =  anyError ?? error
            fallthrough
        default:
            dispatchGroup.leave()
        }
    
        // Add order
        var orderData: [productItemId : quantity] = [:]
        
        order.items.forEach { (arg0) in
            let (productItem, quantity) = arg0
            orderData[productItem.id] = quantity
        }
        
        dispatchGroup.enter()
        orderRef.document(order.id).setData(orderData) { (error) in
            print("Error uploading order: \(error!)")
            anyError = anyError ?? error
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            handler(anyError)
        }
    }
}
