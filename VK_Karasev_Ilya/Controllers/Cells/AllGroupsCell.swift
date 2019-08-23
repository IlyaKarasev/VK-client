//
//  AllGroupsCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 13/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import Kingfisher

class AllGroupsCell: UITableViewCell {

    static let reuseId = "AllGroupsCell"
    
    @IBOutlet var groupnameLabel: UILabel!
        
    @IBOutlet var groupAvatar: AvatarView!
    
    public func configure(with group: Group) {
        let groupname = String(group.name)
        groupnameLabel.text = groupname
        
        let iconUrlString = group.icon
        groupAvatar.clippedImageView.kf.setImage(with: URL(string: iconUrlString))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
