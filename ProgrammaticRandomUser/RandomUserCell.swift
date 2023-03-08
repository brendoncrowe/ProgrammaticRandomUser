//
//  RandomUserCell.swift
//  ProgrammaticRandomUser
//
//  Created by Brendon Crowe on 3/7/23.
//

import UIKit
import ImageKit

class RandomUserCell: UICollectionViewCell {
    
    // user image
    private let userImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    // label for user name
    private let userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.text = "Name"
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setupViews()
        setupLayoutConstraints()
    }
    
    private func setupViews() {
        contentView.layer.cornerRadius = 24
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.backgroundColor = .white
    }
    
    private func setupLayoutConstraints() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for userImageView
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            userImageView.heightAnchor.constraint(equalToConstant: 180.0)
        ])
        
        // Constraints for userNameLabel
        NSLayoutConstraint.activate([
            userNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(for user: RandomUser) {
        userImageView.getImage(with: user.picture.large) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.userImageView.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.userImageView.image = image
                }
            }
        }
        userNameLabel.text = user.name.first.capitalized + " " + user.name.last.capitalized
    }
}
