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
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        self.galleryCollectionView.register(UINib.init(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: "cellIdentifier")
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.galleryCollectionView.reloadData()
            }
        }
       
    }
    
}
//MARK:- UICollectionViewDatasource

extension GalleryViewController : UICollectionViewDataSource{
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.noOfitemsInSection(section: section)
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        
        if let imageObj = viewModel.getModelAt(index: indexPath.row) as Image?{
            if let galleryCell = cell as? GalleryCell {
                galleryCell.titleLabel.text = imageObj.imageTitle
                
                if imageObj.imageURL != nil {
                    galleryCell.imageView.downloadImageFrom(link: imageObj.imageURL!, contentMode: .scaleAspectFit)

                }
                else {
                   // galleryCell.imageView.image = Im

                }
        
            
        }
        return cell
    }
    }
}
extension GalleryViewController : UICollectionViewDelegateFlowLayout {

    

    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

