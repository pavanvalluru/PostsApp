//
//  Loggable.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 12.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

public protocol Loggable {
    func error( _ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func info( _ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func debug( _ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func verbose( _ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func warning( _ object: Any, filename: String, line: Int, column: Int, funcName: String)
    func severe( _ object: Any, filename: String, line: Int, column: Int, funcName: String)
}
