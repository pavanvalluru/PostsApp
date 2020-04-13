//
//  LoginCoordinator.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

class LoginCoordinator: BaseRouterCoordinator {

    var onCoordinatorFinished: ((String) -> Void)?

    override func start(presentationHandler: ((Presentable) -> Void)) {
        presentationHandler(setupLoginView())
    }

    private func setupLoginView() -> UIViewController {
        let loginVM = LoginViewModel()
        loginVM.onFinished = onCoordinatorFinished
        let loginVC = LoginViewController(viewModel: loginVM)
        loginVM.onFailed = { error in
            let alertView = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            loginVC.present(alertView, animated: true)
        }
        return loginVC
    }
}
