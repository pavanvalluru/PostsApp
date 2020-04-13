//
//  AppConfig.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 12.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

final class AppConfig {

    lazy var baseURLString: String = {
        return "https://jsonplaceholder.typicode.com/"
    }()

    static var isRunningUITest: Bool {
        return ProcessInfo().arguments.contains("UITesting")
    }
}

