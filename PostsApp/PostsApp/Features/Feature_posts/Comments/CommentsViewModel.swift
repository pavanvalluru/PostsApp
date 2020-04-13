//
//  CommentsViewModel.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol FavoriteProvider: AnyObject {
    var favoriteHandler: Persistance? { get }
}

protocol CommentsProvider: FavoriteProvider {
    var post: Post { get }
    var comments: [Comment] { get }
    func fetchComments(onCompletion: @escaping (Result<Void, Error>) -> Void)
}

struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

class CommentsViewModel: CommentsProvider {
    var post: Post
    var comments: [Comment] = []

    let favoriteHandler: Persistance?

    init(for post: Post, favoriteHandler: Persistance?) {
        self.post = post
        self.favoriteHandler = favoriteHandler
    }

    func fetchComments(onCompletion: @escaping (Result<Void, Error>) -> Void) {
        let commentsEndPoint = CommentsRequestable(headerParams: [:], queryParams: ["postId": "\(post.id)"])
        PostsFeature.shared.clientService.getDecodedResponse(from: commentsEndPoint, objectType: [Comment].self, completion: { res in
            switch res {
            case .success(let comments):
                self.comments = comments
                onCompletion(.success(()))
            case .failure(let error):
                self.comments.removeAll()
                onCompletion(.failure(error))
            }
        })
    }
}
