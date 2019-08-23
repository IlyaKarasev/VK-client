//
//  NewsTextCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 20/08/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    static let reuseId = "NewsTextCell"
    
    @IBOutlet weak var NewsTextLabel: UITextView!
    
    public func configure(with news: News) {
        let newsText = news.text
        NewsTextLabel.text = newsText
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
