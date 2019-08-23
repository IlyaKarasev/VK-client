//
//  NewsController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 28/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit

class NewsController: UITableViewController, UISearchBarDelegate {

    private let newsService = NetworkingService()
    
    public var newsFeed = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsService.loadNews() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.newsFeed = news
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsFeed.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderCell", for: indexPath) as! NewsHeaderCell
            let news = newsFeed[indexPath.row]
            cell.configure(with: news)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTextCell", for: indexPath) as! NewsTextCell
            let news = newsFeed[indexPath.row]
            cell.configure(with: news)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsContentCell", for: indexPath) as! NewsContentCell
            let news = newsFeed[indexPath.row]
            cell.configure(with: news)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsLikesCell", for: indexPath) as! NewsLikesCell
            let news = newsFeed[indexPath.row]
            cell.configure(with: news)
            return cell
        default:
            return UITableViewCell()
        }
    }
}


