//
//  MyWebService.swift
//  UIKitTemplate
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ResponseRequestable: AnyObject {
    func getDecodedResponse<T: Decodable>(from endPoint: Requestable, objectType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class ClientService: NSObject, ResponseRequestable {

    private let decoder = JSONDecoder()
    private let httpClient: HTTPService
    private let logger: Logger?

    public init(config: NetworkConfigurable) {
        self.logger = config.logger
        self.httpClient = HTTPService(config: config)
    }

    func getDecodedResponse<T: Decodable>(from endPoint: Requestable, objectType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = httpClient.urlRequest(for: endPoint) else {
            return
        }
        httpClient.get(request: request) { data, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                self.logger?.error("invalid response from \(String(describing: request.url))")
                let error = NSError(domain: "Invalid results!", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let model = try self.decoder.decode(objectType, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
