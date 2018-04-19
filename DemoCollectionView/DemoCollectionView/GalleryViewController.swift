//
//  ViewController.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 17/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController{
    
    @IBOutlet var viewModel: ViewModel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
//MARK:- UICollectionViewDatasource

extension GalleryViewController : UICollectionViewDataSource{
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath)
        if let galleryCell = cell as? GalleryCell {
           // annotateCell.photo = photos[indexPath.item]
           // galleryCell.titleLabel.text = "Sample Text"
            
        }
        return cell
    }
    
}

