//
//  PostsViewModelTests.swift
//  PostsAppTests
//
//  Created by Pavan Kumar Valluru on 14.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import PostsApp

class PostsViewModelTests: XCTestCase {

    var sut: PostsViewModel!

    override func setUpWithError() throws {
         _ = PostsFeature.setup(userId: "testUser", networkConfig: TestNetworkConfig(), persistance: nil)
    }

    override func tearDownWithError() throws {

    }

    func testFetchPosts() {
        // given
        let obj = [Post(userId: 3, id: 1, title: "title", body: "body"),
                   Post(userId: 3, id: 2, title: "title", body: "body")]
        let jsonData = try? JSONEncoder().encode(obj)
        sut = PostsViewModel(for: "3", favoriteHandler: nil)
        TestNetworkConfig.mockSession.nextData = jsonData
        let expect = expectation(description: "test fetch posts")
        // when
        sut.fetchPosts(onCompletion: { res in
            expect.fulfill()
        // then
            XCTAssertEqual(self.sut.posts.count, 2)
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}

class TestNetworkConfig: NetworkConfigurable {

    static var mockSession = MockURLSession()

    var baseURL: URL {
        guard let baseUrl = URL(string: "https://test.jsonplaceholder.typicode.com/") else {
            fatalError("invalid base url")
        }
        return baseUrl
    }
    var headers: [String: String] {
        return [:]
    }
    var urlSession: URLSession {
        TestNetworkConfig.mockSession
    }
    var logger: Logger? {
        nil
    }
}
