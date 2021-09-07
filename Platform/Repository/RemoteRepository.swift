//
//  RemoteRepository.swift
//  Platform
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain
import Combine

class RemoteRepository<T, U>: Repository where U: DomainEntityConvertible & Codable, T == U.DomainEntity {

    private let network: Networking
    private let baseURL: URL
    private let endpoint: Endpoint

    init(baseURL: URL, network: Networking, endpoint: Endpoint) {
        self.baseURL = baseURL
        self.network = network
        self.endpoint = endpoint
    }

    // MARK: - Reading from Repository -
    func fetch(withId id: Int, completion: @escaping (Result<T, RepositoryError>) -> Void) {
        let url = self.endpointURL.appendingPathComponent("\(id)")
        let request = URLRequest(url: url)
        network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let item = try self.decoder.decode(U.self, from: data)
                    completion(.success(item.asDomainEntity()))
                } catch let decodingError {
                    completion(.failure(.underlyingError(decodingError)))
                }
            case .failure(let networkError):
                completion(.failure(.underlyingError(networkError)))
            }
        }
    }

    func query(withQueryItems queryItems: [URLQueryItem], completion: @escaping (Result<[T], RepositoryError>) -> Void) {
        guard var urlComponents = URLComponents(url: endpointURL, resolvingAgainstBaseURL: false) else {
            return completion(.failure(.underlyingError(URLError(.badURL))))
        }

        urlComponents.queryItems?.append(contentsOf: queryItems)

        guard let url = urlComponents.url else {
            return completion(.failure(.underlyingError(URLError(.badURL))))
        }

        let request = URLRequest(url: url)
        self.network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let list = try self.decoder.decode([U].self, from: data)
                    completion(.success(list.map { $0.asDomainEntity() }))
                } catch let decodingError {
                    completion(.failure(.underlyingError(decodingError)))
                }
            case .failure(let networkError):
                completion(.failure(.underlyingError(networkError)))
            }
        }
    }

    func fetchAll(_ completion: @escaping (Result<[T], RepositoryError>) -> Void) {
        let request = URLRequest(url: self.endpointURL)
        network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let list = try self.decoder.decode([U].self, from: data)
                    completion(.success(list.map { $0.asDomainEntity() }))
                } catch let decodingError {
                    completion(.failure(.underlyingError(decodingError)))
                }
            case .failure(let networkError):
                completion(.failure(.underlyingError(networkError)))
            }
        }
    }

    // MARK: - Writing to Repository -
    func save(entity: T, completion: @escaping (RepositoryError?) -> Void) {
        save(isUpdate: false, entity: entity, completion: completion)
    }

    func update(entity: T, completion: @escaping (RepositoryError?) -> Void) {
        save(isUpdate: true, entity: entity, completion: completion)
    }

    func delete(entity: T, completion: @escaping (RepositoryError?) -> Void) {
        let url = baseURL.appendingPathComponent(endpoint.relativePath)
        let request = URLRequest(url: url)
        self.network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    guard let dict = json, let success = dict["success"] as? Bool else {
                        return completion(RepositoryError.deleteFailed)
                    }
                    completion(success ? nil : RepositoryError.deleteFailed)
                } catch let decodingError {
                    completion(.underlyingError(decodingError))
                }
            case .failure(let networkError):
                completion(.underlyingError(networkError))
            }
        }
    }

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
//      this is also where you'd set the `keyDecodingStrategy`
//      if you'd be lucky enough to work with a snake_case_endpoint :)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

private extension RemoteRepository {

    var endpointURL: URL {
        baseURL.appendingPathComponent(endpoint.relativePath)
    }

    func save(isUpdate: Bool, entity: T, completion: @escaping (RepositoryError?) -> Void) {
        let url = baseURL.appendingPathComponent(endpoint.relativePath)
        var request = URLRequest(url: url)
        let requestMethod: HTTPMethod = isUpdate ? .patch : .post
        request.httpMethod = requestMethod.rawValue
        request.httpBody = try? JSONEncoder().encode(U(from: entity))
        self.network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    guard let dict = json, let success = dict["success"] as? Bool else {
                        return completion(RepositoryError.saveFailed)
                    }
                    completion(success ? nil : RepositoryError.saveFailed)
                } catch let decodingError {
                    completion(.underlyingError(decodingError))
                }
            case .failure(let networkError):
                completion(.underlyingError(networkError))
            }
        }
    }
}

private extension URL {

    func queryItemAdded(name: String, value: String?) -> URL? {
        return self.queryItemsAdded([URLQueryItem(name: name, value: value)])
    }

    func queryItemsAdded(_ queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: nil != self.baseURL) else {
            return nil
        }
        components.queryItems = queryItems + (components.queryItems ?? [])
        return components.url
    }

}
