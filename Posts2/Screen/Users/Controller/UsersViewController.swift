//
//  UsersViewController.swift
//  Posts2
//
//  Created by Dmytro Ukrainskyi on 13.09.2023.
//

import UIKit

protocol UsersViewControllerDelegate: AnyObject {
    
    func changeUser(to newUser: User)
    
}

class UsersViewController: UIViewController {
    
    // MARK: Public Properties
    
    var user: User?
    
    weak var delegate: UsersViewControllerDelegate?

    // MARK: Private Properties
    
    private let userService: UserService = RealUserService()
    
    private var users: [User] = []
    
    private let tableView = UITableView()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadUsers()
    }
    
    // MARK: Private Methods
    
    private func loadUsers() {
        Task {
            do {
                tableView.showActivityIndicator()
                
                users = try await userService.fetchUsers()
                
                tableView.reloadData()
                tableView.clearBackgroundView()
            } catch {
                tableView.show(error: error as NSError)
            }
        }
    }
    
    @objc
    func handleRefreshControl() {
        loadUsers()
        
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}

// MARK: - UI

private extension UsersViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupRefreshControl()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = user?.name

        setupBackButton()
    }
    
    func setupBackButton() {
        let backButtonImage = UIImage(systemName: Images.back)
        let backButton = UIBarButtonItem(image: backButtonImage,
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector
                                         (UINavigationController.popViewController(animated:))
        )
        backButton.tintColor = .label
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        
        layoutTableView()
    }
    
    func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.backgroundColor = .secondarySystemBackground
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(handleRefreshControl),
                                            for: .valueChanged)
    }
    
    func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - UITableViewDataSource

extension UsersViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return users.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(
            withIdentifier: UserCell.identifier,
            for: indexPath
        ) as? UserCell else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.row]
        
        userCell.configure(name: user.name, username: user.username)
        
        return userCell
    }
    
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.changeUser(to: users[indexPath.row])
        
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension UsersViewController: UIGestureRecognizerDelegate {
    
}
