//
//  BaseRouterCoordinator.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 12.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

open class BaseRouterCoordinator: Coordinator {

    // MARK: - Vars & Lets
    public let rootController: UINavigationController
    public var childCoordinators = [Coordinator]()
    let router: RouterProtocol

    // if the presentation style changes or any other customisation,
    // then we need to pass our own Navigation Controller otherwise default would be fine
    public init(usingNavController: UINavigationController = UINavigationController()) {
        self.rootController = usingNavController
        self.router = Router(rootController: usingNavController)
    }

    // MARK: - Coordinator

    open func start(presentationHandler: ((Presentable) -> Void)) {
        fatalError("Children should implement `start(presentationHandler)`.")
    }
}
