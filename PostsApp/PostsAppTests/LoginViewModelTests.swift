//
//  LoginViewModelTests.swift
//  PostsAppTests
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import PostsApp

class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() {
        sut = LoginViewModel()
        let expect = expectation(description: "login test")
        sut.login(userId: "user", password: nil, onCompletion: {
            expect.fulfill()
        })
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}
