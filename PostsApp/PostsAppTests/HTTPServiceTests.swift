//
//  HTTPServiceTests.swift
//  PostsAppTests
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import PostsApp

class HTTPServiceTests: XCTestCase {

    var sut: HTTPService!
    var testConfig = TestConfig()

    override func setUpWithError() throws {
        sut = HTTPService(config: testConfig)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGet() {
        let urlRequest = sut.urlRequest(for: TestRequestable())!
        let expect = expectation(description: "wait for resume to be called")
        sut.get(request: urlRequest, callback: { _,_ in
            expect.fulfill()
        })
        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertTrue((testConfig.urlSession as? MockURLSession)?.nextDataTask.resumeWasCalled ?? false)
    }

    func testUrlRequestUrl() {
        let urlRequest = sut.urlRequest(for: TestRequestable())!
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://base-test-url/testPath?param1=value1")

    }

    func testUrlRequestHeaderFields() {
        let urlRequest = sut.urlRequest(for: TestRequestable())!
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "header1"), "headerValue1")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "configHeader1"), "configValue1")
    }

}

class TestConfig: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://base-test-url/")!
    var headers: [String: String] = ["configHeader1": "configValue1"]
    var urlSession: URLSession = MockURLSession()
    var logger: Logger?
}

struct TestRequestable: Requestable {
    var path: String = "testPath"

    var method: HTTPMethod = .get

    var headerParamaters: [String: String] = ["header1": "headerValue1"]

    var queryParameters: [String: String] = ["param1": "value1"]
}
