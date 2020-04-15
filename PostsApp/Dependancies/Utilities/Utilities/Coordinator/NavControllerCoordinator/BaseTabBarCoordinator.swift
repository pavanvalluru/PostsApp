//
//  BaseTabBarCoordinator.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 12.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

open class BaseTabBarCoordinator: Coordinator {

    // MARK: - Vars & Lets
    public var childCoordinators = [Coordinator]()
    public var tabBarController = UITabBarController()
    public var tabBarViewControllers = [UIViewController]()

    public init() { }

    open func start(presentationHandler: ((Presentable) -> Void)) {
        fatalError("Children should override this method")
    }

    public func appendToTabBar(presentable: Presentable) {
        if let vc = presentable as? UIViewController {
            tabBarViewControllers.append(vc)
        } else {
            fatalError("Expected a sub class of View Controller")
        }
    }
}
