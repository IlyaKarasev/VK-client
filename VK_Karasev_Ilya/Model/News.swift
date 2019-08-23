//
//  News.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 28/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import SwiftyJSON

class News {
    var sourseID: Int = 0               //ID пользователя или группы
    var date = Date()                   //Дата публикации
    var text: String = ""               //Tекст новости
    var image: String = ""              //Фото
    var likes: Int = 0                  //Кол-во лайков
    var comments: Int = 0               //Кол-во комментариев
    var reposts: Int = 0                //Кол-во репостов
    var views: Int = 0                  //Кол-во просмотров
    var firstname: String = ""          //Имя пользователя
    var lastname: String = ""           //Фамилия пользователя
    var userIcon: String = ""           //Иконка пользователя
    var groupName: String = ""          //Название группы
    var groupIcon: String = ""          //Иконка группы
    
    
    convenience init(_ json: JSON) {
        self.init()

        self.sourseID = json["items"]["source_id"].intValue
        let date = json["items"]["date"].doubleValue
        self.date = Date(timeIntervalSince1970: date)
        self.text = json["items"]["text"].stringValue
        self.image = json["items"]["attachments"][0]["photo"]["sizes"][3]["url"].stringValue
        self.likes = json["items"]["post_source"]["likes"]["count"].intValue
        self.comments = json["items"]["post_source"]["comments"]["count"].intValue
        self.reposts = json["items"]["post_source"]["reposts"]["count"].intValue
        self.views = json["items"]["post_source"]["views"]["count"].intValue
        self.userIcon = json["items"]["profiles"]["photo_50"].stringValue
        self.firstname = json["profile"]["first_name"].stringValue
        self.lastname = json["profile"]["first_name"].stringValue
        self.groupName = json["groups"]["name"].stringValue
        self.groupIcon = json["groups"]["photo_50"].stringValue
    }
}


