//
//  ClientServiceTests.swift
//  PostsAppTests
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import PostsApp

class ClientServiceTests: XCTestCase {

    var sut: ClientService!

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDecodedResponse() {
        // given
        let config = TestConfig()
        let obj = TestModel(name: "Rex", mail: "dogmail")
        let jsonData = try? JSONEncoder().encode(obj)
        (config.urlSession as? MockURLSession)?.nextData = jsonData
        sut = ClientService(config: config)
        // when
        let expect = expectation(description: "decode test")
        sut.getDecodedResponse(from: TestRequestable(), objectType: TestModel.self, completion: { res in
            // then
            expect.fulfill()
            switch res {
            case .success(let model):
                XCTAssertEqual(model.name, "Rex")
                XCTAssertEqual(model.mail, "dogmail")
            default:
                XCTFail("test failed!")
            }
        })
        waitForExpectations(timeout: 2.0, handler: nil)
    }

}

struct TestModel: Codable {
    let name: String
    let mail: String
}
