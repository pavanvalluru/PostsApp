//
//  CoordinatorFinishOutput.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 12.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol CoordinatorFinishFlow {
    var finishFlow: (() -> Void)? { get set }
}
