//
//  PostsProviderProtocol.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol PostsProvider: FavoriteProvider {
    var posts: [Post] { get }
    func fetchPosts(onCompletion: @escaping (Result<Bool, Error>) -> Void)
}

protocol FavoriteProvider: AnyObject {
    var favoriteHandler: FavoriteHandler? { get }
}
