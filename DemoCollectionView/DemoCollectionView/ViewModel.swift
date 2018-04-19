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
    
}
