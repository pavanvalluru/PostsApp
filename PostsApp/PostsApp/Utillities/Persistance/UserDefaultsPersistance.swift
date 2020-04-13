//
//  PostsPersistanceHandler.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol PersistanceProvider  {
    func saveObjectToFavorites(data: Data?)
    func getFavoritesData() -> Data?
}

class UserDefaultsPersistance: PersistanceProvider {

    private let key = "Favorites"

    func getFavoritesData() -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }

    func saveObjectToFavorites(data: Data?) {
        UserDefaults.standard.set(data, forKey: key)
    }
}
