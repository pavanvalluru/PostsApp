//
//  FavoritesViewModel.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol FavoriteHandler {
    func setFavoriteState(to state: Bool, for post: Post)
    func isFavorite(post: Post) -> Bool
}

protocol FavoritesFetchHandler {
    func getAllFavoritePosts() -> [Post]
}

class FavoritesViewModel: PostsProvider {
    var posts: [Post] = []

    var favoriteHandler: FavoriteHandler?

    var fetchHandler: FavoritesFetchHandler?

    init(favoriteHandler: FavoriteHandler?, fetchHandler: FavoritesFetchHandler?) {
        self.favoriteHandler = favoriteHandler
        self.fetchHandler = fetchHandler
    }

    func fetchPosts(onCompletion: @escaping (Result<Void, Error>) -> Void) {
        posts = fetchHandler?.getAllFavoritePosts() ?? []
        onCompletion(.success(()))
    }
}
