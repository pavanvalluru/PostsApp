//
//  MockURLSession.swift
//  PostsApp
//
//  Created by Pavan Kumar Valluru on 13.04.20.
//  Copyright © 2018 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

typealias DataResponse = (data: Data?, urlResponse: URLResponse?, error: Error?)

// This is needed for UITesting
open class MockURLSession: URLSession {

    open var nextDataTask = MockURLSessionDataTask()
    open var nextDownloadTask = MockURLSessionDownloadTask()
    open var nextData: Data?
    open var nextDownloadedFileURL: URL?
    open var nextError: Error?
    open var nextResponse: ((URLRequest) -> URLResponse)?

    open var isUITest: Bool = false

    private (set) var lastURL: URL?

    public convenience init(isUITest: Bool) {
        self.init()
        self.isUITest = isUITest
    }

    // MARK: - Predefined Responses

    private func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    func unauthorizedHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 401, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    func notFoundHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    // MARK: - Predefined Errors

    private func getNoInternetError() -> NSError {
        return NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet,
                       userInfo: [ NSLocalizedDescriptionKey: "Mocked Internet connection appears to be offline."])
    }

    // MARK: - API

    public override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastURL = request.url

        var response: DataResponse

        if isUITest {
            response = getStubbedResponseIfAvailable(for: request) ?? (nil, nil, nil)
        } else {
            let urlResponse: URLResponse = nextResponse?(request) ?? successHttpURLResponse(request: request)
            response = (nextData, urlResponse, nextError)
        }
        completionHandler(response.data, response.urlResponse, response.error)
        return nextDataTask
    }

    public override func downloadTask(with request: URLRequest,
                                      completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void)
        -> URLSessionDownloadTask {
            lastURL = request.url

            var response: DataResponse

            if isUITest {
                response = getStubbedResponseIfAvailable(for: request) ?? (nil, nil, nil)
            } else {
                let urlResponse = nextResponse?(request) ?? successHttpURLResponse(request: request)
                response = (nil, urlResponse, nil)
            }

            completionHandler(nextDownloadedFileURL, response.urlResponse, response.error)

            return nextDownloadTask
    }

    // MARK: - Stub

    private func getStubbedResponseIfAvailable(for request: URLRequest) -> DataResponse? {
        guard ProcessInfo.processInfo.environment["Offline"] == nil else { // used for UI testing
            return (nil, nil, getNoInternetError())
        }

        if let http404url = ProcessInfo.processInfo.environment["http404url"] {
            if let reqURL = request.url?.absoluteString, reqURL == http404url {
                return (data: nil,
                        urlResponse: notFoundHttpURLResponse(request: request),
                        error: nil)
            }
        }
        if let url = request.url, let json = ProcessInfo.processInfo.environment[url.absoluteString.replacingOccurrences(of: "=", with: "+")] {
            let response = successHttpURLResponse(request: request)
            let data = json.data(using: String.Encoding.utf8)
            return (data, response, nil)
        }
        return nil
    }
}

open class MockURLSessionDataTask: URLSessionDataTask {
    private (set) var resumeWasCalled = false

    open override func resume() {
        resumeWasCalled = true
    }
}

open class MockURLSessionDownloadTask: URLSessionDownloadTask {
    private (set) var resumeWasCalled = false

    open override func resume() {
        resumeWasCalled = true
    }
}