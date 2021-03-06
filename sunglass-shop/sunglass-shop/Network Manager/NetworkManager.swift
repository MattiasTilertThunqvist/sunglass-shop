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
import CoreLocation

public let mockedUserID = "00M0L90EHwQaBaCMgXJ0isRhu7i2" // Mocked data, only for demo purpose

class NetworkManager {
    
    // MARK: Properties
    
    static let shared = NetworkManager()
    static let storage = Storage.storage()
    private let productsRef = Firestore.firestore().collection("products")
    private let userRef = Firestore.firestore().collection("users")
    private let storesRef = Firestore.firestore().collection("stores")
    
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
        var items: [productItemId : quantity] = [:]
        
        order.items.forEach { (arg0) in
            let (productItem, quantity) = arg0
            items[productItem.id] = quantity
        }
        
        let orderData: [String:Any] = [
            "id" : order.id,
            "date" : order.date,
            "items" : items
        ]
        
        dispatchGroup.enter()
        userRef.document(user.id).collection("orderHistory").document(order.id).setData(orderData) { (error) in
            if let error = error {
                print("Error uploading order: \(error)")
                anyError = anyError ?? error
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {            
            handler(anyError)
        }
    }
    
    func getUser(handler: @escaping (User?, Error?) -> ()) {
        
        // Load user from Firestore
        userRef.document(mockedUserID).getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error loading user from Firestore: \(error)")
                handler(nil, error)
                return
            }
            
            // User doesn't exist
            if documentSnapshot?.data() == nil {
                print("User doesn't exist")
                handler(nil, nil)
                return
            }
            
            let result = Result {
                try documentSnapshot.flatMap {
                    try $0.data(as: User.self)
                }
            }
            
            switch result {
            case .success(let user):
                handler(user, nil)
            case .failure(let error):
                print("Error converting snapshot to User object: \(error)")
                handler(nil, error)
            }
        }
    }
    
    func getOrders(handler: @escaping ([Order]?, Error?) -> ()) {
        
        // Load from Firestore
        userRef.document(mockedUserID).collection("orderHistory").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error while loading orders: \(error)")
                handler(nil, error)
                return
            }
            guard let querySnapshot = querySnapshot else {
                print("User has no orders")
                handler(nil, nil)
                return
            }
            
            var orders: [Order] = []
            
            for document in querySnapshot.documents {
                let dictionairy = document.data()
                
                guard let id = dictionairy["id"] as? String,
                    let firTimestamp = dictionairy["date"] as? Timestamp,
                    let itemsDictionairy = dictionairy["items"] as? [productItemId : quantity] else {
                        print("Couldn't cast object from Firestore to object")
                        handler(nil, NetworkError.noDocument)
                        return
                }
                
                let items = itemsDictionairy.map({ (arg0) -> (productItem: ProductItem, quantity: quantity) in
                    let (productItemId, quantity) = arg0
                    let productItem = ProductList.shared.getItem(with: productItemId)
                    return (productItem, quantity)
                })
                
                let order = Order(id, firTimestamp.dateValue(), items)
                orders.append(order)
            }
            
            orders.sort(by: { $0.date > $1.date })
            handler(orders, nil)
        }
    }
    
    func getStores(handler: @escaping ([Store], Error?) -> ()) {
        storesRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Couldn't fetch stores: \(error)")
                handler([], error)
                return
            }
            
            guard let querySnapshot = querySnapshot else {
                print("No stores found")
                handler([], NetworkError.noDocument)
                return
            }
            
            var stores = [Store]()
            
            for document in querySnapshot.documents {
                let dictionairy = document.data()
                guard let title = dictionairy["title"] as? String, let geoPoint = dictionairy["coordinates"] as? GeoPoint else {
                    return
                }
                                
                let latitude = CLLocationDegrees(geoPoint.latitude)
                let longitude = CLLocationDegrees(geoPoint.longitude)
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let store = Store(title: title, coordinates: coordinates)
                stores.append(store)
            }
            
            handler(stores, nil)
        }
    }
}
