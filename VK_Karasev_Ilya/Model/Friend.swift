//
//  File.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 10/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class Friend: Object {
    
    @objc enum Gender: Int {
        case male
        case female
        case unknown
    }
    
    @objc enum State: Int {
        case offline
        case online
    }
    
    dynamic var id: Int = 0
    dynamic var firstname: String = ""
    dynamic var lastname: String = ""
    dynamic var friendname: String = ""
    dynamic var avatar: String = ""
    dynamic var city: String = ""
    dynamic var state: State = .offline
    dynamic var gender: Gender = .male
    
    convenience init(_ json: JSON) {
        self.init()
    
        self.id = json["id"].intValue
        self.firstname = json["first_name"].stringValue
        self.lastname = json["last_name"].stringValue
        self.friendname = "\(firstname) \(lastname)"
        self.avatar = json["photo_100"].stringValue
        self.city = json["city"]["title"].stringValue
        self.state = Friend.stateFrom(json: json["online"].intValue)
        self.gender = Friend.genderFrom(json: json["sex"].intValue)
    }
    
    private static func stateFrom(json: Int) -> State {
        switch json {
        case 0: return .offline
        case 1: return .online
        default: fatalError()
        }
    }
    
    private static func genderFrom(json: Int) -> Gender {
        switch json {
        case 0: return .unknown
        case 1: return .female
        case 2: return .male
        default: fatalError()
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//{
//    "response": {
//        "count": 1205,
//        "items": [
//        {
//        "id": 2362,
//        "first_name": "Пётр",
//        "last_name": "Коренев",
//        "is_closed": false,
//        "can_access_closed": true,
//        "sex": 2,
//        "domain": "korenev",
//        "city": {
//        "id": 1,
//        "title": "Москва"
//        },
//        "photo_100": "https://pp.userapi.com/c845324/v845324125/2080e7/lhqECCjCfAU.jpg?ava=1",
//        "online": 0
//        },
//        {
//        "id": 13758,
//        "first_name": "Андрей",
//        "last_name": "Кондрашин",
//        "is_closed": false,
//        "can_access_closed": true,
//        "sex": 2,
//        "domain": "kondrashin",
//        "city": {
//        "id": 1,
//        "title": "Москва"
//        },
//        "photo_100": "https://sun1-28.userapi.com/c850220/v850220455/3490/R4B54EsUpEI.jpg?ava=1",
//        "online": 0
//        },
//        {
//        "id": 15293,
//        "first_name": "Андрей",
//        "last_name": "Куликов",
//        "is_closed": false,
//        "can_access_closed": true,
//        "sex": 2,
//        "domain": "a89095818082",
//        "city": {
//        "id": 2,
//        "title": "Санкт-Петербург"
//        },
//        "photo_100": "https://pp.userapi.com/c621513/v621513754/2bbd8/G70QJXyRrIs.jpg?ava=1",
//        "online": 0
//        },

