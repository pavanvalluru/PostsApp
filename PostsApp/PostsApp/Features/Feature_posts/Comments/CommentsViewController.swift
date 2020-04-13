//
//  CommentsViewController.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class CommentsViewController: UITableViewController {

    private let commentsViewModel: CommentsProvider

    private var loadingIndicator: UIActivityIndicatorView!

    init(viewModel: CommentsProvider) {
        self.commentsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comments"

        setupTableView()
        setupLoadingIndicator()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isBeingPresented || isMovingToParent {
            // Navigation controller is being presented modally
            self.loadingIndicator.startAnimating()
            commentsViewModel.fetchComments() { [weak self] res in
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    switch res {
                    case .success(_):
                        self?.tableView.reloadData()
                    case .failure(let error):
                        let alertView = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self?.present(alertView, animated: true)
                    }
                }
            }
        } else {
            tableView.reloadData()
        }
    }

    // MARK: GUI setup methods

    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.accessibilityIdentifier = "commentsTable"
        tableView.scrollsToTop = true
    }

    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = AppAppearance.Color.ThemeColor
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0).isActive = true
        tableView.bringSubviewToFront(loadingIndicator)
    }
}

extension CommentsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return commentsViewModel.comments.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableCell.self)) ??
                PostTableCell(style: .default, reuseIdentifier: String(describing: PostTableCell.self))
            (cell as? PostTableCell)?.setup(for: commentsViewModel.post, favoriteHandler: commentsViewModel.favoriteHandler)
             return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommentsTableCell.self)) ??
                CommentsTableCell(style: .default, reuseIdentifier: String(describing: CommentsTableCell.self))
            if commentsViewModel.comments.count > indexPath.row {
                (cell as? CommentsTableCell)?.setup(for: commentsViewModel.comments[indexPath.row])
            }
             return cell
        default:
            return UITableViewCell()
        }
    }
}
