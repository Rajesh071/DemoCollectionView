//
//  ImageViewExtension.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 20/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}


