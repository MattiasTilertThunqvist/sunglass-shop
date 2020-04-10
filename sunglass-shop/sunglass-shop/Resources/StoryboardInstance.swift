//
//  StoryboardInstance.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-03.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

final class StoryboardInstance {
    
    private static let productOverview = UIStoryboard(name: "ProductOverview", bundle: nil)
    private static let productDetailsStoryboard = UIStoryboard(name: "ProductDetails", bundle: nil)
    private static let storesStoryboard = UIStoryboard(name: "Stores", bundle: nil)
    private static let tryProductStoryboard = UIStoryboard(name: "TryProduct", bundle: nil)
    private static let checkoutStoryboard = UIStoryboard(name: "Checkout", bundle: nil)
    private static let ordersStoryboard = UIStoryboard(name: "Orders", bundle: nil)

    static func productOverviewViewController() -> ProductOverviewViewController {
        return productOverview.instantiateViewController(identifier: "ProductOverviewViewController") as! ProductOverviewViewController
    }
    
    static func productDetailsViewController() -> ProductDetailsViewController {
        return productDetailsStoryboard.instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
    }
    
    static func storesOnMapViewController() -> StoresOnMapViewController {
        return storesStoryboard.instantiateViewController(identifier: "StoresOnMapViewController") as! StoresOnMapViewController
    }
    
    static func tryProductViewController() -> TryProductViewController {
        return tryProductStoryboard.instantiateViewController(identifier: "TryProductViewController") as! TryProductViewController
    }
    
    static func checkoutViewController() -> CheckoutViewController {
        return checkoutStoryboard.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
    }
    
    static func ordersViewController() -> OrdersViewController {
        return ordersStoryboard.instantiateViewController(identifier: "OrdersViewController") as! OrdersViewController
    }
    
    static func orderInfoViewController() -> OrderInfoViewController {
        return ordersStoryboard.instantiateViewController(identifier: "OrderInfoViewController") as! OrderInfoViewController
    }
}
