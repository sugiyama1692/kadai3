//
//  SliderCellCollectionViewCell.swift
//  SlideshowApp
//
//  Created by mba2408.starlight kyoei.engine on 2024/10/17.
//

import UIKit

class SliderCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    var image: UIImage! {
      didSet {
        imgView.image = image
      }
    }
}
