//
//  PostsViewModel.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

class PostsViewModel: PostsProvider {
    var title: String = "My Posts"
    var posts: [Post] = []
    var favoriteHandler: PostPersistance?

    var onItemSelected: ((Post) -> Void)?

    private let userId: String

    init(for userId: String, favoriteHandler: PostPersistance?) {
        self.userId = userId
        self.favoriteHandler = favoriteHandler
    }

    func fetchPosts(onCompletion: @escaping (Result<Void, Error>) -> Void) {
        let postsEndPoint = PostsRequestable(headerParams: [:], queryParams: ["userId": "\(userId)"])
        PostsHandler(endPoint: postsEndPoint).getPosts() { res in
            switch res {
            case .success(let posts):
                self.posts = posts
                onCompletion(.success(()))
            case .failure(let error):
                self.posts.removeAll()
                onCompletion(.failure(error))
            }
        }
    }
}

class PostsHandler {
    let requestable: Requestable
    init(endPoint: Requestable) {
        self.requestable = endPoint
    }

    func getPosts(onCompletion: @escaping (Result<[Post], Error>) -> Void) {
        PostsFeature.shared.clientService.getDecodedResponse(from: requestable,
                                                             objectType: [Post].self) { res in
            switch res {
            case .success(let posts):
                onCompletion(.success(posts))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}
