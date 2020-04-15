//
//  CustomImageView.swift
//  sunglass-shop
//
//  Created by Mattias Tilert Thunqvist on 2020-03-26.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()
typealias urlString = String

class CustomImageView: UIImageView {

    var imageUrlString: String?
    
    func setImage(from urlString: urlString) {
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else {
            print("Couldn't cast string to url")
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        // Just not to cause a deadlock in UI
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url),
                let image = UIImage(data: imageData) else {
                    print("Error while loading image")
                    return
            }
            
            DispatchQueue.main.async {
                // Ensure that images don't get mixed up during async loading
                if self.imageUrlString == urlString {
                    self.image = image
                }
                
                imageCache.setObject(image, forKey: urlString as NSString)
            }
        }
    }
}
