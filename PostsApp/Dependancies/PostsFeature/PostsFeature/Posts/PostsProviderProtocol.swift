//
//  PostsProviderProtocol.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol PostsProvider: FavoritesProvider {
    var title: String { get }
    var posts: [Post] { get }
    var onItemSelected: ((Post) -> Void)? { get }
    func fetchPosts(onCompletion: @escaping (Result<Void, Error>) -> Void)
}

protocol FavoritesProvider: AnyObject {
    var favoriteHandler: PostPersistance? { get }
}
