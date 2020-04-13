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
        static let ThemeColor = UIColor(red: 76/255.0, green: 114/255.0, blue: 190/255.0, alpha: 1.0)
        static let TintColor = UIColor.white
    }
}
