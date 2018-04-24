//
//  ViewModel.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 19/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    @IBOutlet var moviesClient : ImageClient!
    
    var images : [Image]?
    
    func fetchData(completion:@escaping () -> ()){
        
        moviesClient.fetchImage { images in
            self.images = images
            completion()
        }
    }
    func noOfitemsInSection(section:Int) -> Int{
        return images?.count ?? 0
    }
    
    func getModelAt(index:Int) -> Image {
        if let image = images?[index] as Image? {
            return image
        }
        return Image()
    }
    func removeCacheImages(){
        images?.removeAll()
    }
}
