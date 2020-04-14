//
//  FavoritesViewModelTests.swift
//  PostsAppTests
//
//  Created by Pavan Kumar Valluru on 14.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import PostsApp

class FavoritesViewModelTests: XCTestCase {

    var sut: FavoritesViewModel!

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchFavorites() {
        // given
        sut = FavoritesViewModel(favoriteHandler: TestPersistance())
        let expect = expectation(description: "fetch from local")
        // ehen
        sut.fetchPosts(onCompletion: { res in
            expect.fulfill()
        // then
            XCTAssertEqual(self.sut.posts.count, 3)
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}


class TestPersistance: PostPersistance {

    func setFavoriteState(to state: Bool, for post: Post) {
    }

    func isFavorite(post: Post) -> Bool {
        return true
    }

    func getAllFavorites() -> [Post] {
        return [Post(userId: 3, id: 1, title: "title", body: "body"),
                Post(userId: 3, id: 2, title: "title", body: "body"),
                Post(userId: 3, id: 2, title: "title", body: "body")]
    }

    func removeAllFavorites() {

    }

}
