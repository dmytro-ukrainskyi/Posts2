//
//  PostsViewController.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import UIKit

final class PostsViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let postService: PostService = RealPostService()
    private let userService: UserService = RealUserService()
    
    private var userID: Int = 1
    private var posts: [Post] = []
    
    private let tableView = UITableView()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadUserName()
        loadPosts()
    }
    
    // MARK: Private Methods
    
    private func loadPosts() {
        Task {
            do {
                tableView.showActivityIndicator()
                
                posts = try await postService.fetchPostsForUserWith(id: userID)
                
                tableView.reloadData()
                tableView.clearBackgroundView()
            } catch {
                tableView.show(error: error as NSError)
            }
        }
    }
    
    private func loadUserName() {
        Task {
            do {
                title = try await userService.fetchUserWith(id: userID).name
            } catch {
                tableView.show(error: error as NSError)
            }
        }
    }
    
    @objc
    func handleRefreshControl() {
        loadPosts()
        
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc
    func openUsersViewController() {
        let usersViewController = UsersViewController()
        usersViewController.userID = userID
        
        navigationController?
            .pushViewController(usersViewController, animated: true)
    }
    
}

// MARK: - UI

private extension PostsViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupTableView()
        setupRefreshControl()
    }
    
    func setupNavigationBar() {
        let usersButtonImage = UIImage(named: Images.users)
        
        let usersButton = UIBarButtonItem(
            image: usersButtonImage,
            style: .plain,
            target: self,
            action: #selector(openUsersViewController)
        )
        
        usersButton.tintColor = .label
        
        navigationItem.rightBarButtonItem = usersButton
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        
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

extension PostsViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return posts.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let postCell = tableView.dequeueReusableCell(
            withIdentifier: PostCell.identifier,
            for: indexPath
        ) as? PostCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        
        postCell.configure(title: post.title, body: post.body)
        
        return postCell
    }
    
}

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    
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
        
        let commentsViewController = CommentsViewController()
        commentsViewController.postID = posts[indexPath.row].id
        
        navigationController?
            .pushViewController(commentsViewController, animated: true)
    }
    
}
