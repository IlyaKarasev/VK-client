//
//  UserGroupsController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 08/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsController: UITableViewController, UISearchBarDelegate {

    private let groupsService = NetworkingService()
    private lazy var groups: Results<Group> = try! Realm().objects(Group.self)
    private var notificationToken: NotificationToken?
    
    private var firstLetters = [Character]()      //Массив с первыми буквами
    var sortedGroups = [Character: [Group]]()     //Словарь [первая буква: группы на эту букву]
    private var searchedGroups = [Group]()        //Массив с названиями групп, которые ищет пользователь
    
    
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
        searchBar.placeholder = "Search Groups"
        definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Получаем список групп пользователя
        groupsService.loadGroups() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let groups):
                let realm = try! Realm()
                try! realm.write {
                    realm.add(groups, update: .modified)
                    }
                print(realm.configuration.fileURL!)
                (self.firstLetters, self.sortedGroups) = self.sort(searchedGroups: groups)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        notificationToken = groups.observe { [weak self] changes in
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
    
    //Функция, которая изменяет массив searchedGroups, оставляя те группы, чье название содержит текст, который пользователь набрал в searchBar:
    
    func searchGroups (with text: String) {
        
        searchedGroups = groups.filter { group in
            return group.name.lowercased().contains(text.lowercased())
        }
    }
    
    //Функция, которая в случае если searchBar пуст оставляет массив как есть, а в случае набора текста вызывает функцию searchFriends, которая изменит исходный массив в соответствии с набранным текстом
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchedGroups = Array(groups)
            (firstLetters, sortedGroups) = sort(searchedGroups: searchedGroups)
            tableView.reloadData()
            return
        }
        searchGroups(with: searchText)     //Получаем массив из тех групп, чье название содержит набранный текст
        (firstLetters, sortedGroups) = sort(searchedGroups: searchedGroups)
        tableView.reloadData()
    }
    
    //Функция для сортировки друзей:
    
    private func sort(searchedGroups: [Group]) -> (firstLetters: [Character], sortedFGroups: [Character:[Group]]) {
        
        var firstLetters = [Character]()
        var sortedGroups = [Character: [Group]]()
        
        for group in searchedGroups {
            guard let firstLetter = group.name.first else { continue }
            if  sortedGroups[firstLetter] != nil {
                sortedGroups[firstLetter]!.append(group)
            } else {
                sortedGroups[firstLetter] = [group]
            }
        }
        
        firstLetters = Array(sortedGroups.keys.sorted())
        return (firstLetters, sortedGroups)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstLetters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = firstLetters[section]
        guard let groups = sortedGroups[letter] else { return 0 }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseId, for: indexPath) as? GroupsCell
            else { fatalError("Cell cannot be dequeued") }
        
        let letter = firstLetters[indexPath.section]
        guard let groups = sortedGroups[letter] else { return UITableViewCell() }
        
        let group = groups[indexPath.row]
        cell.configure(with: group)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstLetters[section])
    }

    //MARK: - Editing the table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if let allGroupsController = segue.source as? AllGroupsController,
            let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
            let newGroup = allGroupsController.foundGroups[indexPath.row]
            
            guard !groups.contains(where: { group -> Bool in
                return group.name == newGroup.name
            }) else { return }
            
            //groups.append(newGroup)
            let newIndexPath = IndexPath(item: groups.count-1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}

