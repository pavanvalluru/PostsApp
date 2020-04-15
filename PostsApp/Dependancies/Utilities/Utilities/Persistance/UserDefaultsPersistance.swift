//
//  PostsPersistanceHandler.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

public protocol PersistanceProvider  {
    func saveObjectToFavorites(data: Data?)
    func getFavoritesData() -> Data?
}