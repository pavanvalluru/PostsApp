//
//  AppConfig.swift
//  PostsFeatureDevApp
//
//  Created by Pavan Kumar Valluru on 15.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import PostsFeature

/// This class provides all the necessary configuration for App and its sub-modules
final class AppConfig {

    static var userId: String = "1"

    static var isRunningUITest: Bool {
        return ProcessInfo().arguments.contains("UITesting")
    }

    static var networkConfig: NetworkConfigurable {
        DefaultNetworkConfig()
    }

    static var persistanceManager: PostPersistance? {
        nil
    }

    static var appearance: PostsAppearanceConfig {
        PostsAppearanceConfig(mainColor: .systemBlue, tintColor: .white)
    }
}

class DefaultNetworkConfig: NetworkConfigurable {
    var baseURL: URL {
        guard let baseUrl = URL(string: "https://jsonplaceholder.typicode.com/") else {
            fatalError("invalid base url")
        }
        return baseUrl
    }
    var headers: [String: String] {
        return [:]
    }
    var urlSession: URLSession {
        URLSession.shared
    }
    var logger: Logger? {
        Logger()
    }
}
