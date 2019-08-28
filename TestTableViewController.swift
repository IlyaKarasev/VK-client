//
//  TestTableViewController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 24/08/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {

    private let testNewsService = NetworkingService()
    
    private var items = [TestItems]()
    //private var profiles = [TestNews]()
    //private var groups = [TestNews]()
    
//    private var news = [
//        TestNews(name: 123, text: "блабла", image: UIImage(named:"igor_tsaplin")!),
//        TestNews(name: 1234, text: "блаблабла", image: UIImage(named:"ilya_karasev")!),
//        TestNews(name: 12345, text: "блаблабалбла", image: UIImage(named:"valentin_chuprinov")!)
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        testNewsService.loadNews() { [weak self ] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.reuseId, for: indexPath) as? TestTableViewCell
            else { fatalError("Cell cannot be dequeued") }
        
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}
    
