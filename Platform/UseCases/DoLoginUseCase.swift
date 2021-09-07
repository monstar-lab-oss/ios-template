//
//  DoLoginUseCase.swift
//  Platform
//
//  Created by Aarif Sumra on 2021/09/02.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

final class DoLoginUseCase: Domain.DoLoginUseCase {
    // MARK: - Properties
    private let network: Networking
    private let endpoint: Endpoint
    private let baseURL: URL

    // MARK: - Init
    init(network: Networking, baseURL: URL, endpoint: Endpoint) {
        self.network = network
        self.baseURL = baseURL
        self.endpoint = endpoint
    }

    // MARK: - Execute with parameters
    func execute(_ parameters: (username: String, password: String), completion: ((Result<Bool, Error>) -> Void)?) {
        var request = URLRequest(url: endpointURL)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = HTTPMethod.post.rawValue
        do {
            request.httpBody = try JSONSerialization.data(
                withJSONObject: ["username": parameters.username, "password": parameters.password], options: [])
        } catch let error {
            debugPrint(error.localizedDescription)
            completion?(.failure(error))
        }

        self.network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let item = try self.decoder.decode(Bool.self, from: data)
                    completion?(.success(item))
                } catch let decodingError {
                    completion?(.failure(decodingError))
                }
            case .failure(let networkError):
                completion?(.failure(networkError))
            }
        }
    }
}

extension DoLoginUseCase {

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    private var endpointURL: URL {
        baseURL.appendingPathComponent(endpoint.relativePath)
    }
}
