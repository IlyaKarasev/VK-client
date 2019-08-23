//
//  FriendsPhotosController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 10/04/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsPhotosController: UICollectionViewController {
    
    private let photoService = NetworkingService()
    private lazy var friendphotos: Results<Photo> = try! Realm().objects(Photo.self).filter("ownerId == %@", userID)
    private var notificationToken: NotificationToken?
    
    public var friendname = ""
    public var userID = Int()
    
    //MARK: Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = friendname
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Получаем список фотографий со страницы пользователя
        photoService.loadUserAvatars(for: userID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                let realm = try! Realm()
                try! realm.write {
                    realm.add(photos, update: .modified)
                }
                print(realm.configuration.fileURL!)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        notificationToken = friendphotos.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial, .update:
                self.collectionView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        let width = collectionView.bounds.width / 3.1
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width * 1.25)
        layout.sectionInset = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 0.0, right: 3.0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        notificationToken?.invalidate()
    }

    //MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendphotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsPhotosCell.reuseId, for: indexPath) as? FriendsPhotosCell
            else { fatalError() }
        
        let photo = friendphotos[indexPath.row]
        cell.configure(with: photo)
        //cell.likeControl.addTarget(self, action: #selector(cellLikePressed(_:)), for: .valueChanged)
        return cell
    }

    //Mark - Private
    @objc func cellLikePressed(_ sender: LikeControl) {
        print("The cell liked status set to: \(sender.likeState).")
    }
}







