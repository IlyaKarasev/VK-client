//
//  NetworkingService.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 26/05/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class NetworkingService {
    
    let baseUrl = "https://api.vk.com"      //Общая часть URL для всех запросов    
    let token = KeychainWrapper.standard.string(forKey: "access_token") ?? ""
    //let token = Session.sessionInfo.token   //Используем токен сохраненный с синглтоне
    
    //Создаем свою сессию с определенными параметрами:
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let session = SessionManager(configuration: config)
        return session
    }()
    
    
    // Получение списка групп
    public func loadGroups(completion: ((Swift.Result<[Group], Error>) -> Void)? = nil) {
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": "1",                  //Выводим информацию в расширенном виде
            "v": "5.95"
        ]
        
        NetworkingService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result  {
            case .success(let value):
                let json = JSON(value)
                let groups = json["response"]["items"].arrayValue.map { Group($0) }
                completion?(.success(groups))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    //Глобальный поиск по группам
    public func findGroups(for searchText: String, completion: ((Swift.Result<[Group], Error>) -> Void)? = nil) {
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q" : searchText,
            "type" : "group",
            "v" : "5.95"
        ]
        
        NetworkingService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result  {
            case .success(let value):
                let json = JSON(value)
                let foundGroups = json["response"]["items"].arrayValue.map { Group($0) }
                completion?(.success(foundGroups))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    //Получение списка друзей
    public func loadFriends(completion: ((Swift.Result<[Friend], Error>) -> Void)? = nil) {
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "fields": "city, sex, domain, photo_100",  //Выводим город, nickname, пол и фото
            "v": "5.95"
        ]
        
        NetworkingService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result  {
            case .success(let value):
                let json = JSON(value)
                let friends = json["response"]["items"].arrayValue.map { Friend($0) }
                completion?(.success(friends))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    //Получение фотографий пользователя
    public func loadUserAvatars(for userID: Int, completion: ((Swift.Result<[Photo], Error>) -> Void)? = nil) {
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "owner_id": userID,
            "album_id": "profile",      //Выводим список аватарок пользователя
            "photo_sizes": "1",         //Выводим разные размеры фотографий
            "rev": "1",                 //Выводим сначала новые, а потом более старые фото
            "v": "5.95"
        ]
        
        NetworkingService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result  {
            case .success(let value):
                let json = JSON(value)
                let photos = json["response"]["items"].arrayValue.map { Photo($0) }
                completion?(.success(photos))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    // Получаем список новостей
    public func loadNews(completion: ((Swift.Result<[News], Error>) -> Void)? = nil) {
        let path = "/method/newsfeed.get"
        
        let params: Parameters = [
            "access_token": token,
            "filters": "post",
            "count": "5",
            "v": "5.95"
        ]
        
        NetworkingService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let news = json["response"].arrayValue.map { News($0) }
                completion?(.success(news))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
