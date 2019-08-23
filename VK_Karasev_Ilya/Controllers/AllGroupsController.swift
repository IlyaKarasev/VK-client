//
//  AllFriendsController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 08/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {
    
    private let groupsSearchService = NetworkingService()
    
    var foundGroups = [Group]()    //Найденные группы
    
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        
        //Setup for SearchBar:
        searchBar.placeholder = "Search Groups"
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            foundGroups.removeAll()
            tableView.reloadData()
            return
        }
        groupsSearchService.findGroups(for: searchText) { [weak self ] result in
            guard let self = self else { return }
            switch result {
            case .success(let foundGroups):
                self.foundGroups = foundGroups
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foundGroups.count
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllGroupsCell.reuseId, for: indexPath) as? AllGroupsCell
            else { fatalError("Cell cannot be dequeued") }
    
        let group = foundGroups[indexPath.row]
        cell.configure(with: group)
        return cell
    }
}
