//
//  ViewController.swift
//  ProgrammaticRandomUser
//
//  Created by Brendon Crowe on 3/7/23.
//

import UIKit
import NetworkHelper

class RandomUserController: UIViewController {
    
    private let randomUserView = RandomUserView()
    
    var randomUsers = [RandomUser]() {
        didSet {
            randomUserView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = randomUserView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Random Users"
        setCollectionViewDelegates()
        randomUserView.collectionView.register(RandomUserCell.self, forCellWithReuseIdentifier: "randomUserCell")
    }
    
    private func setCollectionViewDelegates() {
        randomUserView.collectionView.delegate = self
        randomUserView.collectionView.dataSource = self
    }
    
    func fetchUsers() {
        RandomUserAPIClient.fetchUsers { [weak self] result in
            switch result {
            case .failure(let appError):
                print("There was an error fetching the users: \(appError)")
                break
            case .success(let users):
                DispatchQueue.main.async {
                    self?.randomUsers = users
                }
            }
        }
    }
}

extension RandomUserController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "randomUserCell", for: indexPath) as? RandomUserCell else {
            fatalError("could not dequeue a RandomUserCell")
        }
        let user = randomUsers[indexPath.row]
        cell.configureCell(for: user)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 15 // space between items
        let maxWidth = (view.window?.windowScene?.screen.bounds.size.width)! // device's width
        let numberOfItems: CGFloat = 2 // items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
