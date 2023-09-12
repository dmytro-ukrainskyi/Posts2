//
//  UserCell.swift
//  Posts2
//
//  Created by Dmytro Ukrainskyi on 13.09.2023.
//

import UIKit

class UserCell: UITableViewCell {

    static let identifier = "UserCell"
    
    // MARK: Private Properties
    
    private let nameLabel = UILabel()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: Public Methods
    
    func configure(name: String, username: String) {
        nameLabel.text = "\(name) (\(username))"
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(nameLabel)

        nameLabel.font = .boldSystemFont(ofSize: Constants.nameLabelFontSize)
        nameLabel.numberOfLines = Constants.nameLabelNumberOfLines
        
        layoutNameLabel()
    }
    
    private func layoutNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel
                .topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: Constants.verticalSpacing * 3),
            nameLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: Constants.horizontalSpacing * 3),
            nameLabel
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: Constants.horizontalSpacing * -3),
            nameLabel
                .bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: Constants.verticalSpacing * -3)
        ])
    }
    
}

// MARK: - Constants

private extension UserCell {
    
    enum Constants {
        
        static let nameLabelFontSize: CGFloat = 17
        static let nameLabelNumberOfLines: Int = 0

        static let verticalSpacing: CGFloat = 8
        static let horizontalSpacing: CGFloat = 8
        
    }
    
}
