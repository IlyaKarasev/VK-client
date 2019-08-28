//
//  NewsLikesCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 20/08/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class NewsLikesCell: UITableViewCell {
    
    static let reuseId = "NewsLikesCell"
        
    
    @IBOutlet weak var NewsLikeLabel: UILabel!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var ShareLabel: UILabel!
    @IBOutlet weak var WatchLabel: UILabel!
    
    @IBAction func NewsLikeControl(_ sender: LikeControl) {
    }
    
    @IBAction func CommentButton(_ sender: UIButton) {
    }
    
    @IBAction func ShareButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var WatchImageView: UIImageView!
    
    public func configure(with news: News) {
        let likes = news.likes
        NewsLikeLabel.text = String(likes)
        
        let comments = news.comments
        CommentLabel.text = String(comments)
        
        let reposts = news.reposts
        ShareLabel.text = String(reposts)
        
        let views = news.views
        WatchLabel.text = String(views)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
