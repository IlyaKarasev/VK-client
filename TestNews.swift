//
//  TestNews.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 24/08/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import SwiftyJSON

class TestItems {
    var name: String
    var text: String
    var image: String
    
    init(_ json: JSON) {
        
        self.name = String(json["source_id"].intValue)
        self.text = json["text"].stringValue
        self.image = json["attachments"][0]["photo"]["sizes"][3]["url"].stringValue
    }
}
