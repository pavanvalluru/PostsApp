//
//  FavoritesViewModel.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

class FavoritesViewModel: PostsProvider {
    var title: String = "Favorites"
    var posts: [Post] = []

    var onItemSelected: ((Post) -> Void)?

    var favoriteHandler: PostPersistance?

    init(favoriteHandler: PostPersistance?) {
        self.favoriteHandler = favoriteHandler
    }

    func fetchPosts(onCompletion: @escaping (Result<Void, Error>) -> Void) {
        posts = favoriteHandler?.getAllFavorites() ?? []
        onCompletion(.success(()))
    }
}
