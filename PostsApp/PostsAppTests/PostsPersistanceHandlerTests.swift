//
//  PersistanceProviderTests.swift
//  PostsAppTests
//
//  Created by Pavan Kumar Valluru on 14.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import PostsApp

class PostsPersistanceHandlerTests: XCTestCase {

    var sut: PostsPersistanceHandler!

    override func setUpWithError() throws {
        sut = PostsPersistanceHandler(provider: TestProvider())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetFavoriteState() {
        let post = Post(userId: 1, id: 1, title: "title", body: "body")

        sut.setFavoriteState(to: true, for: post)
        XCTAssertTrue(sut.isFavorite(post: post))

        sut.setFavoriteState(to: false, for: post)
        XCTAssertFalse(sut.isFavorite(post: post))
    }

    func testGetAllFavorites() {
        let p1 = Post(userId: 1, id: 1, title: "title", body: "body")
        let p2 = Post(userId: 1, id: 2, title: "title", body: "body")
        let p3 = Post(userId: 1, id: 3, title: "title", body: "body")

        sut.setFavoriteState(to: true, for: p1)
        sut.setFavoriteState(to: true, for: p2)
        sut.setFavoriteState(to: true, for: p3)

        XCTAssertEqual(sut.getAllFavorites().count, 3)

        sut.setFavoriteState(to: false, for: p3)
        XCTAssertEqual(sut.getAllFavorites().count, 2)
    }

    func testRemoveAllfavorites() {
        let p1 = Post(userId: 1, id: 1, title: "title", body: "body")
        let p2 = Post(userId: 1, id: 2, title: "title", body: "body")
        let p3 = Post(userId: 1, id: 3, title: "title", body: "body")

        sut.setFavoriteState(to: true, for: p1)
        sut.setFavoriteState(to: true, for: p2)
        sut.setFavoriteState(to: true, for: p3)

        sut.removeAllFavorites()
        XCTAssertEqual(sut.getAllFavorites().count, 0)
    }

}

class TestProvider: PersistanceProvider {
    var data: Data?

    func saveObjectToFavorites(data: Data?) {
        self.data = data
    }

    func getFavoritesData() -> Data? {
        return data
    }
}
