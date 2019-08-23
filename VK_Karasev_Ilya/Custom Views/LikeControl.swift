//
//  LikeControl.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 23/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class LikeControl: UIControl {

    public var likeState: Bool = false
    let likeImageView = UIImageView()
    var numberOfLikes = UILabel(frame: CGRect(x: 0, y:0, width: 10, height: 15)) {
        didSet {
            numberOfLikes.text = "0"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likeImageView.isUserInteractionEnabled = true
        likeImageView.addGestureRecognizer(tapGR)
        likeImageView.image = UIImage(named: "heart_empty")
        addSubview(likeImageView)
        
        numberOfLikes.center = CGPoint(x: 30, y: 10)
        numberOfLikes.textColor = #colorLiteral(red: 0.5331459045, green: 0.5331588984, blue: 0.5331519246, alpha: 1)
        numberOfLikes.font = numberOfLikes.font.withSize(14)
        numberOfLikes.text = "0"
        addSubview(numberOfLikes)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        likeImageView.frame = bounds
    }

    //MARK - Private
    @objc func likeTapped() {
        likeState.toggle()
        numberOfLikes.text = likeState ? "1" : "0"
        numberOfLikes.textColor = likeState ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.5331459045, green: 0.5331588984, blue: 0.5331519246, alpha: 1)
        likeImageView.image = likeState ? UIImage(named: "heart_red") : UIImage(named: "heart_empty")
        sendActions(for: .valueChanged)
    }
}
