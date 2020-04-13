//
//  PostsTableCell.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class PostTableCell: UITableViewCell {

    private let favButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderColor = AppAppearance.Color.ThemeColor.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = AppAppearance.Color.ThemeColor
        btn.setTitleColor(AppAppearance.Color.TintColor, for: .normal)
        btn.setTitle("FAV", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private var containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = AppAppearance.Color.ThemeColor.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.lineBreakMode = .byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let bodyLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private var favoriteHandler: FavoriteHandler?
    private var post: Post?

    private var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                favButton.backgroundColor = AppAppearance.Color.ThemeColor
                favButton.setTitleColor(AppAppearance.Color.TintColor, for: .normal)
            } else {
                favButton.backgroundColor = AppAppearance.Color.TintColor
                favButton.setTitleColor(AppAppearance.Color.ThemeColor, for: .normal)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none

        addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])


        favButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        containerView.addSubview(favButton)
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            favButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            favButton.heightAnchor.constraint(equalToConstant: 50),
            favButton.widthAnchor.constraint(equalToConstant: 50)
        ])

        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: favButton.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: favButton.leadingAnchor, constant: -10)
        ])

        containerView.addSubview(bodyLabel)
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])

    }

    @objc private func favoriteTapped() {
        isFavorite.toggle()
        if let post = self.post, let favHndler = favoriteHandler {
            favHndler.setFavoriteState(to: isFavorite, for: post)
        }

    }

    func setup(for post: Post, favoriteHandler: FavoriteHandler?) {
        self.post = post
        self.favoriteHandler = favoriteHandler
        isFavorite = favoriteHandler?.isFavorite(post: post) ?? false

        titleLabel.text = post.title.capitalized
        bodyLabel.text = post.body.capitalized
    }

}
