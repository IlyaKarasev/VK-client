//
//  FriendsCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 10/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsCell: UITableViewCell {

    static let reuseId = "FriendsCell"
    
    @IBOutlet var friendnameLabel: UILabel!
    
    @IBOutlet var friendAvatar: AvatarView!
        
    @IBOutlet var onlineIcon: UIImageView!
    
    public func configure(with friend: Friend) {
        let friendname = "\(friend.firstname) \(friend.lastname)"
        friendnameLabel.text = friendname
        
        let iconUrlString = friend.avatar
        friendAvatar.clippedImageView.kf.setImage(with: URL(string: iconUrlString))
        
        let onlineState = friend.state
        switch onlineState {
        case .online:
                onlineIcon.isHidden = false
        case .offline:
                onlineIcon.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
