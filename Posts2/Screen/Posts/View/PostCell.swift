//
//  PostCell.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import UIKit

final class PostCell: UITableViewCell {

    static let identifier = "PostCell"
    
    // MARK: Private Properties
    
    private let titleLabel = UILabel()
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
    
    func configure(title: String, body: String) {
        titleLabel.text = title
        bodyLabel.text = body
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        
        titleLabel.font = .boldSystemFont(ofSize: Constants.titleLabelFontSize)
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        
        bodyLabel.numberOfLines = Constants.bodyLabelNumberOfLines
        
        layoutTitleLabel()
        layoutBodyLabel()
    }
    
    private func layoutTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel
            .setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        titleLabel
            .setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            titleLabel
                .topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: Constants.verticalSpacing * 3),
            titleLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: Constants.horizontalSpacing * 3),
            titleLabel
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
                .constraint(equalTo: titleLabel.bottomAnchor,
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

private extension PostCell {
    
    enum Constants {
        
        static let titleLabelFontSize: CGFloat = 17
        static let titleLabelNumberOfLines: Int = 1
        
        static let bodyLabelNumberOfLines: Int = 2

        static let verticalSpacing: CGFloat = 8
        static let horizontalSpacing: CGFloat = 8
        
    }
    
}
