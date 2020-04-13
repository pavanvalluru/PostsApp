//
//  LoginFeature.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

/// depends on Networking Module and Coordinator module
/// This is the entry point for Login feature
public class LoginFeature {
    internal static let shared = LoginFeature()

    private struct Config {
        var networkConfig: NetworkConfigurable
    }
    private static var config: Config?

    internal var clientService: ClientService {
        ClientService(config: LoginFeature.config!.networkConfig)
    }

    internal var logger: Logger? {
        LoginFeature.config?.networkConfig.logger
    }

    private init() {
        guard LoginFeature.config != nil else {
            fatalError("Error - you must call setup before accessing LoginFeature.shared")
        }
    }

    public class func setup(networkConfig: NetworkConfigurable) -> Coordinator {
        let config = Config(networkConfig: networkConfig)
        LoginFeature.config = config

        return LoginCoordinator()
    }
}
