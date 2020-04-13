//
//  Post.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let userId: Int64
    let id: Int64
    let title: String
    let body: String
}
