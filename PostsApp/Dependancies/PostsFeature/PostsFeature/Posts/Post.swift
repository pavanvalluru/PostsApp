//
//  Post.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

public struct Post: Codable, Equatable {
    let userId: Int64
    public let id: Int64
    let title: String
    let body: String
}
