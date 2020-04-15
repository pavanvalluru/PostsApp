//
//  PostsViewController.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

protocol FavoritesUpdatable {
    func updateFavoritesView()
}

class PostsViewController: UITableViewController {

    private let postsViewModel: PostsProvider

    private var loadingIndicator: UIActivityIndicatorView!

    init(viewModel: PostsProvider) {
        self.postsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = postsViewModel.title
        setupTableView()
        setupLoadingIndicator()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateContent()
    }

    private func updateContent() {
        self.loadingIndicator.startAnimating()
        postsViewModel.fetchPosts() { [weak self] res in
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
        tableView.allowsSelection = true
        tableView.accessibilityIdentifier = "postsTable"
        tableView.scrollsToTop = true
    }

    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = PostsFeature.shared.appearance?.mainColor
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0).isActive = true
        tableView.bringSubviewToFront(loadingIndicator)
    }
}

extension PostsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = postsViewModel.posts.count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableCell.self)) ??
            PostTableCell(style: .default, reuseIdentifier: String(describing: PostTableCell.self))
        if postsViewModel.posts.count > indexPath.row {
            (cell as? PostTableCell)?.setup(for: postsViewModel.posts[indexPath.row],
                                            favoriteHandler: postsViewModel.favoriteHandler,
                                            updateDelegate: self)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postsViewModel.posts[indexPath.row]
        postsViewModel.onItemSelected?(post)
    }
}

extension PostsViewController: FavoritesUpdatable {
    func updateFavoritesView() {
        if postsViewModel is FavoritesViewModel {
            self.updateContent()
        }
    }
}
