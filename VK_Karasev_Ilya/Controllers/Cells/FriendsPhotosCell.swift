//
//  FriendsPhotosCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 10/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsPhotosCell: UICollectionViewCell {
    
    static let reuseId = "FriendsPhotosCell"
    
    @IBOutlet var friendPhotoView: UIImageView!
    
    @IBOutlet var likeControl: LikeControl!
    
    public func configure(with photo: Photo) {
  
        var iconUrlString = photo.middleImage
        if iconUrlString == "" {
            iconUrlString = photo.smallImage
            friendPhotoView.kf.setImage(with: URL(string: iconUrlString))
        } else {
            iconUrlString = photo.middleImage
            friendPhotoView.kf.setImage(with: URL(string: iconUrlString))
        }
    }
}
