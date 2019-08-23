//
//  NewsHeaderCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 20/08/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import Kingfisher

class NewsHeaderCell: UITableViewCell {
    
    static let reuseId = "NewsHeaderCell"
        
    @IBOutlet weak var NewsAvatarView: AvatarView!   
    @IBOutlet weak var NewsProfileLabel: UILabel!
    
    public func configure(with news: News) {
        
        let sourseID = news.sourseID
        if sourseID > 0 {
            let profileName = "\(news.firstname) \(news.lastname)"
            NewsProfileLabel.text = profileName
            
            let iconUrlString = news.userIcon
            NewsAvatarView.clippedImageView.kf.setImage(with: URL(string: iconUrlString))
        } else {
            let profileName = news.groupName
            NewsProfileLabel.text = profileName
            
            let iconUrlString = news.groupIcon
            NewsAvatarView.clippedImageView.kf.setImage(with: URL(string: iconUrlString))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
