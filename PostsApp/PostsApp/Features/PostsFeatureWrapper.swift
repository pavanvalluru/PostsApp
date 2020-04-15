//
//  PostsFeatureWrapper.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 15.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import PostsFeature

class PostsFeatureWrapper {
    static var postsAppearance: PostsAppearanceConfig {
        PostsAppearanceConfig(mainColor: AppAppearance.Color.ThemeColor, tintColor: AppAppearance.Color.TintColor)
    }

    static var networkConfig: NetworkConfigurable {
        AppConfig.networkConfig as! NetworkConfigurable
    }

    static var persistanceManager: PostPersistance {
        MyPersistanceHandler()
    }
}

class MyPersistanceHandler: PostPersistance {
    // can be provided with setup method
    private let persistanceProvider: PersistanceProvider

    init(provider: PersistanceProvider = UserDefaultsPersistance()) {
        self.persistanceProvider = provider
    }

    public func setFavoriteState(to state: Bool, for post: Post) {
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

    public func isFavorite(post: Post) -> Bool {
        return getAllFavorites().contains(post)
    }

    public func getAllFavorites() -> [Post] {
        if let data = persistanceProvider.getFavoritesData(),
            let favorites = try? JSONDecoder().decode([Post].self, from: data) {
            return favorites
        }
        return []
    }

    public func removeAllFavorites() {
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
