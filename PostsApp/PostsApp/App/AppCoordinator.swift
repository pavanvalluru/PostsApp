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
        let loginCoord = LoginCoordinator()
        loginCoord.onCoordinatorFinished = {
            self.removeAllChildCoordinators()
            self.startPostsFeature()
        }
        loginCoord.start(presentationHandler: { vc in
            self.addChildCoordinator(loginCoord)
            if let vc = vc.toPresent() {
                self.swapRootViewController(to: vc)
            }
        })
    }

    func startPostsFeature() {
        let postsCoord = PostsCoordinator()
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

            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = newController
            }, completion: nil)
        }
    }
}
