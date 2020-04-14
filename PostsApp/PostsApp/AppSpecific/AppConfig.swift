//
//  AppConfig.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 12.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

final class AppConfig {

    static var isRunningUITest: Bool {
        return ProcessInfo().arguments.contains("UITesting")
    }

    static var networkConfig: NetworkConfigurable {
        DefaultNetworkConfig()
    }

    static var persistanceManager: PostPersistance {
        PostsPersistanceHandler()
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
        AppConfig.isRunningUITest ? MockURLSession() : URLSession.shared
    }
    var logger: Logger? {
        Logger()
    }
}
