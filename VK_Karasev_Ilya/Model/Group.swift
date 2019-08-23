//
//  Group.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 10/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class Group: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var icon: String = ""
    dynamic var privacy: Int = 0
    
    convenience init(_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.icon = json["photo_100"].stringValue
        self.privacy = json["is_closed"].intValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}





//"response": {
//    "count": 222,
//    "items": [
//    {
//    "id": 96219277,
//    "name": "GetLens | Профессиональная фототехника |",
//    "screen_name": "get_lens",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun9-8.userapi.com/c840534/v840534085/5d053/ewyVxX8nmQU.jpg?ava=1",
//    "photo_100": "https://sun9-20.userapi.com/c840534/v840534085/5d052/vkPsfpOdc84.jpg?ava=1",
//    "photo_200": "https://sun9-17.userapi.com/c840534/v840534085/5d051/QUVDB6WaGmM.jpg?ava=1"
//    },
//    {
//    "id": 14495031,
//    "name": "Adobe Premiere Pro",
//    "screen_name": "club14495031",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun9-8.userapi.com/c636230/v636230776/275a1/qVUpjSR9q-8.jpg?ava=1",
//    "photo_100": "https://sun9-13.userapi.com/c636230/v636230776/275a0/N2mV3sUNG04.jpg?ava=1",
//    "photo_200": "https://sun9-32.userapi.com/c636230/v636230776/2759f/LtIFHe5vVgg.jpg?ava=1"
//    },
//    {
//    "id": 169768688,
//    "name": "Складчина Фото & Видео",
//    "screen_name": "sklad.photovideo",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun9-31.userapi.com/c853620/v853620219/2c621/ohtWLlzOPnQ.jpg?ava=1",
//    "photo_100": "https://sun9-8.userapi.com/c853620/v853620219/2c620/QceBG7rz4rM.jpg?ava=1",
//    "photo_200": "https://sun9-32.userapi.com/c853620/v853620219/2c61f/LDPMIFmAaGw.jpg?ava=1"
//    },
//    {
//    "id": 117457776,
//    "name": "Андрей Захарян | Официальная группа",
//    "screen_name": "andreyzakharyan",
//    "is_closed": 0,
//    "type": "page",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun9-2.userapi.com/c638719/v638719922/eb8a/oLEmFJLn3Kg.jpg?ava=1",
//    "photo_100": "https://sun9-5.userapi.com/c638719/v638719922/eb89/wAK4jVaRq4w.jpg?ava=1",
//    "photo_200": "https://sun9-24.userapi.com/c638719/v638719922/eb87/REIRHF271z4.jpg?ava=1"
//    },
//    {
//    "id": 82587152,
//    "name": "Sony A7, A7s, A7r - III, A9, RX10 - III, А6500",
//    "screen_name": "sony_a7s",
//    "is_closed": 0,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun9-5.userapi.com/c625323/v625323305/12e02/j2fz-pWaEnw.jpg?ava=1",
//    "photo_100": "https://sun9-34.userapi.com/c625323/v625323305/12e01/MDhZMSVmC5A.jpg?ava=1",
//    "photo_200": "https://sun9-18.userapi.com/c625323/v625323305/12e00/6tc4hIGh5bI.jpg?ava=1"
//    },
//    {
//    "id": 35193970,
//    "name": "Perception of music",
//    "screen_name": "pmpage",
//    "is_closed": 0,
//    "type": "page",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun9-28.userapi.com/c636217/v636217226/16b47/XC55O_HBY2c.jpg?ava=1",
//    "photo_100": "https://sun9-29.userapi.com/c636217/v636217226/16b46/XJTXm8uJrnM.jpg?ava=1",
//    "photo_200": "https://sun9-27.userapi.com/c636217/v636217226/16b45/ERSGjjB_ZVk.jpg?ava=1"
//    },
//    {
//    "id": 98450,
//    "name": "Rammstein",
//    "screen_name": "rammstein",
//    "is_closed": 1,
//    "type": "group",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://sun9-1.userapi.com/c847217/v847217306/1e2727/OgjdOGKSvZw.jpg?ava=1",
//    "photo_100": "https://sun9-13.userapi.com/c847217/v847217306/1e2726/6HQAvk5sJXQ.jpg?ava=1",
//    "photo_200": "https://sun9-19.userapi.com/c847217/v847217306/1e2725/LYZ1WfxIa14.jpg?ava=1"
//    },
//    {
//    "id": 166105559,
//    "name": "Camerasales",
//    "screen_name": "camerasales",
//    "is_closed": 0,
//    "type": "page",
//    "is_admin": 0,
//    "is_member": 1,
//    "is_advertiser": 0,
//    "photo_50": "https://pp.userapi.com/c830709/v830709565/1336e7/0HWMJI1CcfU.jpg?ava=1",
//    "photo_100": "https://pp.userapi.com/c830709/v830709565/1336e6/RQCHR15lXqk.jpg?ava=1",
//    "photo_200": "https://pp.userapi.com/c830709/v830709565/1336e5/u0m5otjStuw.jpg?ava=1"
//    },
