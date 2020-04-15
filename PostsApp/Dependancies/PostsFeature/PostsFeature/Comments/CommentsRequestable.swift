//
//  CommentsRequestable.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import Utilities

struct CommentsRequestable: Requestable {
    var path: String = "comments"

    var method: HTTPMethod = .get

    var headerParamaters: [String : String]

    var queryParameters: [String : String]

    init(headerParams: [String: String], queryParams: [String: String]) {
        self.headerParamaters = headerParams
        self.queryParameters = queryParams
    }
}
