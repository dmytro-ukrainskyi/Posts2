//
//  CommentCell.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import UIKit

class CommentCell: UITableViewCell {

    static let identifier = "CommentCell"
    
    // MARK: Private Properties
    
    private let emailLabel = UILabel()
    private let bodyLabel = UILabel()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: Public Methods
    
    func configure(email: String, body: String) {
        emailLabel.text = email
        bodyLabel.text = body
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(emailLabel)
        contentView.addSubview(bodyLabel)
        
        emailLabel.font = .boldSystemFont(ofSize: Constants.emailLabelFontSize)
        emailLabel.numberOfLines = Constants.emailLabelNumberOfLines
        
        bodyLabel.numberOfLines = Constants.bodyLabelNumberOfLines
        
        layoutTitleLabel()
        layoutBodyLabel()
    }
    
    private func layoutTitleLabel() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel
            .setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        emailLabel
            .setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            emailLabel
                .topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: Constants.verticalSpacing * 3),
            emailLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: Constants.horizontalSpacing * 3),
            emailLabel
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: Constants.horizontalSpacing * -3)
        ])
    }
    
    private func layoutBodyLabel() {
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bodyLabel
            .setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        bodyLabel
            .setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            bodyLabel
                .topAnchor
                .constraint(equalTo: emailLabel.bottomAnchor,
                            constant: Constants.verticalSpacing * 2),
            bodyLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: Constants.horizontalSpacing * 3),
            bodyLabel
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: Constants.horizontalSpacing * -3),
            bodyLabel
                .bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: Constants.verticalSpacing * -3)
        ])
    }
    
}

// MARK: - Constants

private extension CommentCell {
    
    enum Constants {
        
        static let emailLabelFontSize: CGFloat = 17
        static let emailLabelNumberOfLines: Int = 1
        
        static let bodyLabelNumberOfLines: Int = 2

        static let verticalSpacing: CGFloat = 8
        static let horizontalSpacing: CGFloat = 8
        
    }
    
}
