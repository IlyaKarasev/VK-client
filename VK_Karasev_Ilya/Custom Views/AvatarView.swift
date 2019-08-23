//
//  AvatarView.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 19/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

@IBDesignable class ShadowView: UIView {
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowRadius: CGFloat = 7
    @IBInspectable var shadowOpacity: Float = 0.7
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3.0, height: -3.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.masksToBounds = false
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = bounds.height/2
    }
}

class ClippedImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        self.layer.masksToBounds = true
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.height/2
    }
}

class AvatarView: UIView {
    
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowRadius: CGFloat = 7
    @IBInspectable var shadowOpacity: Float = 0.7
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 3.0, height: -3.0)
    var avatarImage: UIImage = UIImage(named: "friend")! {
        didSet {
            clippedImageView.image = avatarImage
        }
    }
    let shadowView = ShadowView()
    let clippedImageView = ClippedImageView(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.masksToBounds = false
        addSubview(shadowView)
        
        clippedImageView.image = avatarImage
        addSubview(clippedImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.frame = bounds
        clippedImageView.frame = bounds
    }
}



