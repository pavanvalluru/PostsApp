//
//  AppCoordinator.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    func start(presentationHandler: ((Presentable) -> Void)) {
        self.removeAllChildCoordinators()
        self.startLoginFeature()
    }

    func startLoginFeature() {
        guard let loginCoord = LoginFeature.setup(networkConfig: AppConfig.networkConfig) as? LoginCoordinator else {
            AppConfig.networkConfig.logger?.error("invalid login feature setup")
            fatalError("invalid login feature setup")
        }
        loginCoord.onCoordinatorFinished = { id in
            self.removeAllChildCoordinators()
            self.startPostsFeature(for: id)
        }
        loginCoord.start(presentationHandler: { vc in
            self.addChildCoordinator(loginCoord)
            if let vc = vc.toPresent() {
                self.swapRootViewController(to: vc)
            }
        })
    }

    func startPostsFeature(for user: String) {
        let postsCoord = PostsFeature.setup(userId: user, networkConfig: AppConfig.networkConfig)
        postsCoord.start( presentationHandler: { vc in
            self.addChildCoordinator(postsCoord)
            if let vc = vc.toPresent() {
                self.swapRootViewController(to: vc)
            }
        })
    }

    private func swapRootViewController(to newController: UIViewController) {
        let scene = UIApplication.shared.connectedScenes.first

        if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate),
            let window = sd.window {
            window.rootViewController?.dismiss(animated: false, completion: nil)
            window.rootViewController = newController
        }
    }
}
