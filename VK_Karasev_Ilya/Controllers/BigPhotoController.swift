//
//  BigPhotoController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 03/07/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class BigPhotoController: UIViewController {

    @IBOutlet weak var bigImageView: UIImageView!
    
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.bigImageView.image = currentImage
    }
}





