//
//  CommentsViewModelTests.swift
//  PostsAppTests
//
//  Created by Pavan Kumar Valluru on 14.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import PostsApp

class CommentsViewModelTests: XCTestCase {

    var sut: CommentsViewModel!

    override func setUpWithError() throws {
         _ = PostsFeature.setup(userId: "testUser", networkConfig: TestNetworkConfig(), persistance: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchComments() {
        // given
        let obj = [Comment(postId: 1, id: 1, name: "user", email: "email", body: "body"),
                   Comment(postId: 1, id: 2, name: "user", email: "email", body: "body")]
        let jsonData = try? JSONEncoder().encode(obj)
        TestNetworkConfig.mockSession.nextData = jsonData // mock expected data

        let post = Post(userId: 1, id: 1, title: "title", body: "body")
        sut = CommentsViewModel(for: post, favoriteHandler: nil)
        let expect = expectation(description: "test fetch comments")
        // when
        sut.fetchComments(onCompletion: { res in
            expect.fulfill()
        // then
            XCTAssertEqual(self.sut.comments.count, 2)
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}
