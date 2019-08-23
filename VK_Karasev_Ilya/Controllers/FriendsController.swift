//
//  UserFriendsController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 08/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsController: UITableViewController, UISearchBarDelegate {
    
    private let friendsService = NetworkingService()
    private lazy var friends: Results<Friend> = try! Realm().objects(Friend.self)
    private var notificationToken: NotificationToken?
    
    private var firstLetters = [Character]()                    //Массив с первыми буквами
    var sortedFriends = [Character: [Friend]]()                 //Словарь [первая буква: друзья на эту букву]
    private var searchedFriends = [Friend]()                    //Массив с именами, которые ищет пользователь (когда searchBar пуст он равен исходному массиву friends)
    
    
    //SearchBar:
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    //MARK: Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        
        //Setup for SearchBar:
        searchBar.placeholder = "Search Friends"
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Получаем список друзей пользователя
        friendsService.loadFriends() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                let realm = try! Realm()
                try! realm.write {
                    realm.add(friends, update: .modified)
                }
                print(realm.configuration.fileURL!)
                (self.firstLetters, self.sortedFriends) = self.sort(searchedFriends: friends)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        notificationToken = friends.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        notificationToken?.invalidate()
    }
    
    // Функция, которая изменяет массив searchedFriends, оставляя тех друзей, чья фамилия содержит текст, который пользователь набрал в searchBar:
    func searchFriends (with text: String) {
        
        searchedFriends = friends.filter { friend in
            return friend.friendname.lowercased().contains(text.lowercased())
        }
    }
    
    //Функция, которая в случе если searchBar пуст оставляет массив как есть, а в случае набора текста вызывает функцию searchFriends, которая изменит исходный массив в соответствии с набранным текстом
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchedFriends = Array(friends)
            (firstLetters, sortedFriends) = sort(searchedFriends: searchedFriends)
            tableView.reloadData()
            return
        }
        searchFriends(with: searchText)     //Получаем массив из тех друзей, чье имя сожержит набранный текст
        (firstLetters, sortedFriends) = sort(searchedFriends: searchedFriends)
        tableView.reloadData()
    }

    //Функция для сортировки друзей:
    private func sort(searchedFriends: [Friend]) -> (firstLetters: [Character], sortedFriends: [Character: [Friend]]) {
        
        var firstLetters = [Character]()
        var sortedFriends = [Character: [Friend]]()
        
        for friend in searchedFriends {
            guard let firstLetter = friend.lastname.first else { continue }
            if  sortedFriends[firstLetter] != nil {
                sortedFriends[firstLetter]!.append(friend)
            } else {
                sortedFriends[firstLetter] = [friend]
            }
        }
        
        firstLetters = Array(sortedFriends.keys.sorted())
        return (firstLetters, sortedFriends)
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstLetters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let letter = firstLetters[section]
        guard let friends = sortedFriends[letter] else { return 0 }
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseId, for: indexPath) as? FriendsCell
            else { fatalError("Cell cannot be dequeued") }
        
        let letter = firstLetters[indexPath.section]
        guard let friends = sortedFriends[letter] else { return UITableViewCell() }
        
        let friend = friends[indexPath.row]
        cell.configure(with: friend)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstLetters[section])
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var firstLettersString = [String]()
        for letter in firstLetters {
            let stringLetter = String(letter)
            firstLettersString.append(stringLetter)
        }
        return firstLettersString
    }

    
    // MARK: - Navigation (передаем имя пользователя в заголовок контроллера с фотографиями выбранного пользователя)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendPhotos",
        
            let friendphotosVC = segue.destination as? FriendsPhotosController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            let letter = firstLetters[indexPath.section]
            let friends = sortedFriends[letter]!
            
            let friendname = "\(friends[indexPath.row].firstname) \(friends[indexPath.row].lastname)"
            friendphotosVC.friendname = friendname
            let userID = friends[indexPath.row].id
            friendphotosVC.userID = userID
        }
    }
}



