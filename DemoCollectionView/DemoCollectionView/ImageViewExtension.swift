//
//  ImageViewExtension.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 20/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()


extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        if let cachedImage = imageCache.object(forKey: link as NSString) {
            image=cachedImage;
        } else {
        
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data {
                    imageCache.setObject(self.image!, forKey: link as NSString)
                    self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

}
