//
//  PostsFeature.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import Utilities

/// depends on Networking Module and coordinator module
/// This is the entry point for Posts feature
public class PostsFeature {
    internal static let shared = PostsFeature()

    private struct Config {
        var networkConfig: NetworkConfigurable
        let appearance: PostsAppearanceConfig
        let userId: String
    }
    private static var config: Config?

    internal var clientService: ClientService {
        ClientService(config: PostsFeature.config!.networkConfig)
    }

    internal var logger: Logger? {
        PostsFeature.config?.networkConfig.logger
    }

    internal var appearance: PostsAppearanceConfig? {
        PostsFeature.config?.appearance
    }

    private init() {
        guard PostsFeature.config != nil else {
            fatalError("Error - you must call setup before accessing Postsfeature.shared")
        }
    }

    public class func setup(userId: String,
                            networkConfig: NetworkConfigurable,
                            appearance: PostsAppearanceConfig,
                            persistance: PostPersistance?) -> Coordinator {
        let config = Config(networkConfig: networkConfig,
                            appearance: appearance,
                            userId: userId)
        PostsFeature.config = config

        return PostsCoordinator(for: userId, persistance: persistance)
    }

}
