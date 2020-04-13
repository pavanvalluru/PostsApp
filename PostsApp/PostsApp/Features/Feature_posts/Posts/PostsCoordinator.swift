//
//  AppCoordinator.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class PostsCoordinator: BaseTabBarCoordinator {

    let userId: String

    init(for userId: String) {
        self.userId = userId
    }

    override func start(presentationHandler: ((Presentable) -> Void)) {
        setupTabBarItems()
        presentationHandler(tabBarController)
    }

    private func setupTabBarItems() {
        // first tab
        let allPostsVM = PostsViewModel(for: self.userId, favoriteHandler: nil)
        let firstTabVC = PostsViewController(viewModel: allPostsVM)
        let firstTabNavC = UINavigationController(rootViewController: firstTabVC)
        firstTabNavC.tabBarItem.title = "My Posts"
        self.appendToTabBar(presentable: firstTabNavC)

        // second tab
        let favoritesVM = FavoritesViewModel(favoriteHandler: nil, fetchHandler: nil)
        let secondTabVC = PostsViewController(viewModel: favoritesVM)
        let secondTabNavC = UINavigationController(rootViewController: secondTabVC)
        secondTabNavC.tabBarItem.title = "Favorites"
        self.appendToTabBar(presentable: secondTabNavC)

        tabBarController.viewControllers = tabBarViewControllers
        tabBarController.tabBar.accessibilityIdentifier = "MainTabBar"
    }
}

