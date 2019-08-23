//
//  NewsContentCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 20/08/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import Kingfisher

class NewsContentCell: UITableViewCell {
    
    static let reuseId = "NewsContentCell"
    
    @IBOutlet weak var NewsImageView: UIImageView!
    
    public func configure(with news: News) {
        let iconUrlString = news.image
        NewsImageView.kf.setImage(with: URL(string: iconUrlString))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
