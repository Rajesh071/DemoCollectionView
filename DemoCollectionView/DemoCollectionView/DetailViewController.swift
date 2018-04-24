//
//  DetailViewController.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 23/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit
let kStatusBarHeight:CGFloat = 20.0

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    var imageModel: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descText.text = imageModel?.titleDesc
        self.title = imageModel?.imageTitle
        if let imageURL = imageModel?.imageURL as String?{
            //fetch the image if it is in the cache
            if let cachedImage = appDelegate.imageCache.object(forKey: imageURL as NSString) as UIImage? {
                detailImageView.image = cachedImage

            }
        }
        else {
            detailImageView.image = #imageLiteral(resourceName: "NoImage")

        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.resizeSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            self.resizeSubViews()

            
        })        
    }
    
    
    func resizeSubViews(){
        if UIDevice.current.orientation.isLandscape {
            self.detailImageView.frame = CGRect(x: self.view.frame.origin.x, y: ((appDelegate.window?.frame.size.height)!-(appDelegate.window?.frame.size.height)!/2)/2, width: 0.3 * self.view.frame.size.width, height: self.view.frame.size.height/2)
            self.descText.frame = CGRect(x:self.detailImageView.frame.size.width+10,y:self.detailImageView.frame.origin.y,width:((appDelegate.window?.frame.size.width)!-(self.detailImageView.frame.width)),height:self.detailImageView.frame.size.height+kStatusBarHeight)
        } else {
            self.detailImageView.frame = CGRect(x: ((appDelegate.window?.frame.size.width)!-self.view.frame.size.width/2)/2, y: 64
                , width: self.view.frame.size.width/2, height: self.view.frame.size.width/2)
            self.descText.frame = CGRect(x:0,y:self.detailImageView.frame.origin.y+self.detailImageView.frame.size.height+kStatusBarHeight,width:(appDelegate.window?.frame.size.width)!,height:self.detailImageView.frame.size.height)
            
        }
    }

}
