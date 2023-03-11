//
//  DetailController.swift
//  ProgrammaticRandomUser
//
//  Created by Brendon Crowe on 3/7/23.
//

import UIKit
import ImageKit

class DetailController: UIViewController {
    
    public var user: RandomUser?
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.backgroundColor = .systemBackground
        iv.image = UIImage(systemName: "person.fill")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 24
        iv.layer.borderWidth = 2
        return iv
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Hi Brendon"
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        setupLayoutConstraints()
        configureUI()
    }
    
    private func setupLayoutConstraints() {
        view.addSubview(imageView)
        view.addSubview(userNameLabel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints for imageView
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 375),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // constraints for userNameLabel
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureUI() {
        if let user = user {
            userNameLabel.text = "User Name: " + user.name.first.capitalized + " " + user.name.last.capitalized
            imageView.getImage(with: user.picture.large) { [weak self] result in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(systemName: "person.fill")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
}
