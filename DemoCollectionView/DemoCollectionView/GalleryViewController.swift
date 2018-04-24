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
let sectInset = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 30.0, right: 20.0)
let appDelegate = UIApplication.shared.delegate as! AppDelegate


class GalleryViewController: UIViewController{
    
    @IBOutlet var viewModel: ViewModel!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    @IBOutlet weak var refreshCache: UIBarButtonItem!
    

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
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //Resizing cell but image will be loaded from cached if cahced already
        if UIDevice.current.orientation.isLandscape {
            self.galleryCollectionView.reloadData()
        } else {
            self.galleryCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            var indexpath = sender as! IndexPath
            if let imageObj = viewModel.getModelAt(index: indexpath.row) as Image?{
            let vc = segue.destination as! DetailViewController
            vc.imageModel = imageObj
            }
        
    }
    @IBAction func onRefreshPressed(_ sender: Any) {
        appDelegate.imageCache.removeAllObjects()
        galleryCollectionView.isHidden=true
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.galleryCollectionView.isHidden=false
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
        
        if let imageObj = viewModel.getModelAt(index: indexPath.row) as Image? {
            if let galleryCell = cell as? GalleryCell {
                galleryCell.cellTag = imageObj.imageURL
                galleryCell.titleLabel.text = imageObj.imageTitle
                galleryCell.imageView.image = #imageLiteral(resourceName: "NoImage")

                if let imageURL = imageObj.imageURL as String?{
                //fetch the image if it is in the cache
                if let cachedImage = appDelegate.imageCache.object(forKey: imageURL as NSString) as UIImage? {
                        
                        galleryCell.imageView.image = cachedImage
                        
                    }
                    else{
                     let task =   URLSession.shared.dataTask( with: NSURL(string:imageURL)! as URL, completionHandler: {
 
                            (data, response, error) -> Void in
                            DispatchQueue.main.async {
                                if let data1 = data as Data?{
                                    //Load/Save the image in the cache
                                    if let image = UIImage(data:data1) as UIImage?{
                                    appDelegate.imageCache.setObject(image, forKey: imageURL as NSString )
                                        if galleryCell.cellTag == imageURL {
                                            galleryCell.imageView.image = UIImage(data: data1)
                                            galleryCell.imageView.contentMode = .scaleAspectFit
                                        }

                                    }
                                    
                                }
                            }
                        }
                    )
                    task.resume()
                }
            }
        }
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = kCornerRadius;
        return cell
        }
    }
}
//MARK:- UICollectionViewDelegate

extension GalleryViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailViewController", sender: indexPath)
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



