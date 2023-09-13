//
//  UITableView + Extensions.swift
//  Posts
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import UIKit

extension UITableView {
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        backgroundView = activityIndicator
    }
        
    func show(error: NSError) {
        let errorLabel = UILabel()
        backgroundView = errorLabel
        
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.font = .boldSystemFont(ofSize: 20)
        errorLabel.text = "\(error.localizedDescription) \n\n Error Code: \(error.code)"
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -32)
        ])
    }
    
    func clearBackgroundView() {
        backgroundView = nil
    }
    
}
