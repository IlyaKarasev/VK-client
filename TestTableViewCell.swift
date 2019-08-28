//
//  TestTableViewCell.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 24/08/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import Kingfisher

class TestTableViewCell: UITableViewCell {

    static let reuseId = "TestCell"
    
    @IBOutlet weak var TestNameLabel: UILabel!
    
    @IBOutlet weak var TestTextLabel: UILabel!
    
    @IBOutlet weak var TestImageView: UIImageView!
    
    public func configure(with item: TestItems) {
        let name = item.name
        TestNameLabel.text = name
        
        let text = item.text
        TestTextLabel.text = text
        
        let image = item.image
        TestImageView.kf.setImage(with: URL(string: image))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
