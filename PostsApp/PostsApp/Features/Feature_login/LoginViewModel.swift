//
//  LoginViewModel.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol LoginProvider: AnyObject {
    func login(userId: String, password: String?, onCompletion: @escaping (() -> Void))
}

enum LoginError: LocalizedError {
    case invalidCredentials
    case noNetwork

    var errorDescription: String? {
        return "error message!"
    }
}

class LoginViewModel: LoginProvider {
    var onFailed: ((Error) -> Void)?
    var onFinished: ((String) -> Void)?

    func login(userId: String, password: String?, onCompletion: @escaping (() -> Void)) {
        let result = validateUserCredentials(id: userId, password: password)
        DispatchQueue.main.async {
            switch result{
            case.success(_):
                self.onFinished?(userId)
            case .failure(let error):
                self.onFailed?(error)
            }
            onCompletion()
        }
    }

    private func validateUserCredentials(id: String, password: String?) -> Result<String, Error> {
        guard !id.isEmpty else {
            return .failure(LoginError.invalidCredentials)
        }
        return .success("access_token")
    }
}

// This may take over network call or offline login etc.
class LoginHandler {

}
