//
//  Photo.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 07/06/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class Photo: Object {
    dynamic var id: Int = 0
    dynamic var date = Date()
    dynamic var ownerId: Int = 0
    dynamic var smallImage: String = ""
    dynamic var middleImage: String = ""
    dynamic var largeImage: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        
        let date = json["date"].doubleValue
        self.date = Date(timeIntervalSince1970: date)
        
        self.ownerId = json["owner_id"].intValue
        self.smallImage = json["sizes"][2]["url"].stringValue
        self.middleImage = json["sizes"][8]["url"].stringValue
        self.largeImage = json["sizes"][6]["url"].stringValue
        
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["largeImage"]
    }
}

//{
//    "response": {
//        "count": 15,
//        "items": [
//        {
//        "id": 456240023,
//        "album_id": -6,
//        "owner_id": 1108481,
//        "sizes": [
//        {
//        "type": "m",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d02fa/WT4RgmwZhf8.jpg",
//        "width": 87,
//        "height": 130
//        },
//        {
//        "type": "o",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d02ff/rNSPadMpfyM.jpg",
//        "width": 130,
//        "height": 195
//        },
//        {
//        "type": "p",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d0300/XTwAqt546Hg.jpg",
//        "width": 200,
//        "height": 300
//        },
//        {
//        "type": "q",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d0301/weUzC2TQuXI.jpg",
//        "width": 320,
//        "height": 481
//        },
//        {
//        "type": "r",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d0302/67E7KxYiel8.jpg",
//        "width": 510,
//        "height": 766
//        },
//        {
//        "type": "s",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d02f9/n8ADGtFcOE0.jpg",
//        "width": 50,
//        "height": 75
//        },
//        {
//        "type": "w",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d02fe/coGiUUpEjms.jpg",
//        "width": 833,
//        "height": 1252
//        },
//        {
//        "type": "x",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d02fb/zrER6urgB98.jpg",
//        "width": 402,
//        "height": 604
//        },
//        {
//        "type": "y",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d02fc/MgJ5TtGH1Eo.jpg",
//        "width": 537,
//        "height": 807
//        },
//        {
//        "type": "z",
//        "url": "https://pp.userapi.com/c831308/v831308782/1d02fd/UOQJf-lz8dE.jpg",
//        "width": 719,
//        "height": 1080
//        }
//        ],
//        "text": "",
//        "date": 1541804516,
//        "post_id": 1280
//        },
//        {
//        "id": 456239941,
//        "album_id": -6,
//        "owner_id": 1108481,
//        "sizes": [
//        {
//        "type": "m",
//        "url": "https://pp.userapi.com/c847021/v847021428/83071/FBdteRLEe80.jpg",
//        "width": 97,
//        "height": 130
//        },
//        {
//        "type": "o",
//        "url": "https://pp.userapi.com/c847021/v847021428/83076/SK_7Aqww_9Y.jpg",
//        "width": 130,
//        "height": 173
//        },
//        {
//        "type": "p",
//        "url": "https://pp.userapi.com/c847021/v847021428/83077/DbSUJyWJgUE.jpg",
//        "width": 200,
//        "height": 267
//        },
//        {
//        "type": "q",
//        "url": "https://pp.userapi.com/c847021/v847021428/83078/6NZCWXY_qQc.jpg",
//        "width": 320,
//        "height": 427
//        },
//        {
//        "type": "r",
//        "url": "https://pp.userapi.com/c847021/v847021428/83079/SYZHqSSUNW4.jpg",
//        "width": 510,
//        "height": 680
//        },
//        {
//        "type": "s",
//        "url": "https://pp.userapi.com/c847021/v847021428/83070/QQOXB-epCvI.jpg",
//        "width": 56,
//        "height": 75
//        },
//        {
//        "type": "w",
//        "url": "https://pp.userapi.com/c847021/v847021428/83075/O2edhhxAcJk.jpg",
//        "width": 1620,
//        "height": 2160
//        },
//        {
//        "type": "x",
//        "url": "https://pp.userapi.com/c847021/v847021428/83072/81rsL3mbLos.jpg",
//        "width": 453,
//        "height": 604
//        },
//        {
//        "type": "y",
//        "url": "https://pp.userapi.com/c847021/v847021428/83073/cQDjbS_2eik.jpg",
//        "width": 605,
//        "height": 807
//        },
//        {
//        "type": "z",
//        "url": "https://pp.userapi.com/c847021/v847021428/83074/IBb0n9Ygy3c.jpg",
//        "width": 810,
//        "height": 1080
//        }
//        ],
