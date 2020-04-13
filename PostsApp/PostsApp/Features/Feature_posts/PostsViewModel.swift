//
//  PostsViewModel.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

class PostsViewModel: PostsProvider {
    var posts: [Post] = []
    var favoriteHandler: FavoriteHandler?

    private let userId: String

    init(for userId: String, favoriteHandler: FavoriteHandler?) {
        self.userId = userId
        self.favoriteHandler = favoriteHandler
    }

    func fetchPosts(onCompletion: @escaping (Result<Bool, Error>) -> Void) {
        let postsEndPoint = PostsRequestable(headerParams: [:], queryParams: ["userId": "\(userId)"])
        PostsFeature.shared.clientService.getDecodedResponse(from: postsEndPoint, objectType: [Post].self, completion: { res in
            switch res {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                self.posts.removeAll()
            }
        })
    }
}

class PostsRequestable: Requestable {
    var path: String = "posts"

    var method: HTTPMethod = .get

    var headerParamaters: [String : String]

    var queryParameters: [String : String]

    init(headerParams: [String: String], queryParams: [String: String]) {
        self.headerParamaters = headerParams
        self.queryParameters = queryParams
    }
}
