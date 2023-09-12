//
//  CommentsViewController.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import UIKit

class CommentsViewController: UIViewController {
    
    // MARK: Public Properties
    
    var postID: Int?
    
    // MARK: Private Properties
    
    private let commentService: CommentService = RealCommentService()
    
    private var comments: [Comment] = []
    
    private let tableView = UITableView()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadComments()
    }
    
    // MARK: Private Methods
    
    private func loadComments() {
        guard let postID else { return }
        
        Task {
            do {
                tableView.showActivityIndicator()
                
                comments = try await commentService.fetchCommentsForPostWith(id: postID)
                
                title = "Comments (\(comments.count))"
                
                tableView.reloadData()
                tableView.clearBackgroundView()
            } catch {
                tableView.show(error: error as NSError)
            }
        }
    }
    
    @objc
    func handleRefreshControl() {
        loadComments()
        
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}

// MARK: - UI

private extension CommentsViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupRefreshControl()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = "Comments (0)"
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
        
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        
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

extension CommentsViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return comments.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let commentCell = tableView.dequeueReusableCell(
            withIdentifier: CommentCell.identifier,
            for: indexPath
        ) as? CommentCell else {
            return UITableViewCell()
        }
        
        let comment = comments[indexPath.row]
        
        commentCell.configure(email: comment.email, body: comment.body)
        
        return commentCell
    }
    
}

// MARK: - UITableViewDelegate

extension CommentsViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension CommentsViewController: UIGestureRecognizerDelegate {
    
}
