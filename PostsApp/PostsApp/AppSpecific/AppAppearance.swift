//
//  AppAppearance.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

final class AppAppearance {

    static func setupAppearance() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = Color.ThemeColor
        standard.titleTextAttributes = [.foregroundColor: Color.TintColor]
        UINavigationBar.appearance().standardAppearance = standard

        // Set color of titles and icons in tabBar
        UITabBar.appearance().tintColor = Color.TintColor
        // Set color of background tabBar
        UITabBar.appearance().barTintColor = Color.ThemeColor
    }

    enum Color {
        static let ThemeColor = UIColor(named: "ThemeColor")
        static let TintColor = UIColor.white
    }
}
