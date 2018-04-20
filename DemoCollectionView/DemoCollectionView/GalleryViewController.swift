//
//  ViewController.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 17/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit
let kCornerRadius:CGFloat = 6.0
let itemPerRow: CGFloat = 3
let sectInset = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)


class GalleryViewController: UIViewController{
    
    @IBOutlet var viewModel: ViewModel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    

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
                
        }
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = kCornerRadius;
        return cell
    }
    }
}
//MARK:- UICollectionViewDelegateFlowLayout

extension GalleryViewController : UICollectionViewDelegateFlowLayout {


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectInset.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectInset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectInset.left
    }
}

