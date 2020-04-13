//
//  LoginCoordinator.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class LoginCoordinator: BaseRouterCoordinator {

    var onCoordinatorFinished: (() -> Void)?

    override func start(presentationHandler: ((Presentable) -> Void)) {
        let loginVM = LoginViewModel()
        loginVM.onFinished = onCoordinatorFinished
        let loginVC = LoginViewController(viewModel: loginVM)
        presentationHandler(loginVC)
    }
}
