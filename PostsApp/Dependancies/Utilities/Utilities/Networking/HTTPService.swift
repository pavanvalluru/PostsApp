//
//  HTTPClient.swift
//  UIKitTemplate
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2018 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

public protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var urlSession: URLSession { get }
    var logger: Logger? { get }
}

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var headerParamaters: [String: String] { get }
    var queryParameters: [String: String] { get }
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

typealias CompleteClosure = (_ data: Data?, _ error: Error?) -> Void

// MARK: HttpClient Implementation
class HTTPService {

    private let config: NetworkConfigurable
    private let logger: Logger?

    init(config: NetworkConfigurable) {
        self.config = config
        self.logger = config.logger
    }

    func get(request: URLRequest, callback: @escaping CompleteClosure) {
        let task = self.getSessionDataTask(for: request, callback: callback)
        task.resume()
    }

    private func getSessionDataTask(for request: URLRequest, callback: @escaping CompleteClosure) -> URLSessionDataTask {
        let task = config.urlSession.dataTask(with: request) { (data, _, error) in
            callback(data, error)
        }
        return task
    }

    func urlRequest(for request: Requestable) -> URLRequest? {
        var components = URLComponents(url: config.baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: true)
        components?.queryItems = request.queryParameters.map {URLQueryItem(name: $0.key, value: $0.value)}

        guard let url = components?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        config.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        request.headerParamaters.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }

        return urlRequest
    }
}
