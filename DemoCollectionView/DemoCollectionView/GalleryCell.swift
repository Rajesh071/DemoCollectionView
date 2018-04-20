//
//  GalleryCell.swift
//  DemoCollectionView
//
//  Created by Test User 1 on 18/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var cellTag:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
