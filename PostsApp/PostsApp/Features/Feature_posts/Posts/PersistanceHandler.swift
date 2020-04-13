//
//  PersistanceHandler.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol Persistance {
    func setFavoriteState(to state: Bool, for post: Post)
    func isFavorite(post: Post) -> Bool
    func getAllFavorites() -> [Post]
    func removeAllFavorites()
}

class PersistanceHandler: Persistance {

    static let shared = PersistanceHandler()

    private init() { }

    private var persistanceProvider: PersistanceProvider = UserDefaultsPersistance()

    func setFavoriteState(to state: Bool, for post: Post) {
        var favorites = getAllFavorites()
        if state {
            favorites.append(post)
        } else {
            favorites.removeAll { $0.id == post.id }
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            persistanceProvider.saveObjectToFavorites(data: data)
        } catch {
            print("Can't encode data: \(error)")
        }
    }

    func isFavorite(post: Post) -> Bool {
        return getAllFavorites().contains(post)
    }

    func getAllFavorites() -> [Post] {
        if let data = persistanceProvider.getFavoritesData(),
            let favorites = try? JSONDecoder().decode([Post].self, from: data) {
            return favorites
        }
        return []
    }

    func removeAllFavorites() {
        do {
            let array: [Post] = []
            let encoder = JSONEncoder()
            let data = try encoder.encode(array)
            persistanceProvider.saveObjectToFavorites(data: data)
        } catch {
            print("Can't encode data: \(error)")
        }
    }
}

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
