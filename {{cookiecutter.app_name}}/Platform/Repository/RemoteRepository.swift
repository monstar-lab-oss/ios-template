//
//  RemoteRepository.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © 2021 {{cookiecutter.company_name}} All rights reserved.
//

import Domain
import Combine

class RemoteRepository<E: Endpoint>: RepositoryType, Combinable {

    let network: Networking

    private let baseURL: URL
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
//      this is also where you'd set the `keyDecodingStrategy`
//      if you'd be lucky enough to work with a snake_case_endpoint :)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    private var endpointURL: URL {
        baseURL.appendingPathComponent(E.relativePath)
    }

    public init(baseURL: URL, network: Networking) {
        self.baseURL = baseURL
        self.network = network
    }

    func queryAll(_  completion: @escaping (Result<[E.Resource], Error>) -> Void) {
        let request = URLRequest(url: self.endpointURL)
        network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let list = try self.decoder.decode(List<E.Resource>.self, from: data)
                    completion(.success(list.results))
                } catch let error {
                    completion(.failure(error)) // DecodingError
                }
            case .failure(let error):
                completion(.failure(error)) // NetworkError
            }
        }
    }

    func query(with queryString: String, completion: @escaping (Result<[E.Resource], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL.absoluteString) else {
            return completion(.failure(URLError(.badURL)))
        }

        urlComponents.path = E.relativePath
        urlComponents.query = queryString

        guard let url = urlComponents.url else {
            return completion(.failure(URLError(.badURL)))
        }

        let request = URLRequest(url: url)
        self.network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let list = try self.decoder.decode(List<E.Resource>.self, from: data)
                    completion(.success(list.results))
                } catch let error {
                    completion(.failure(error)) // DecodingError
                }
            case .failure(let error):
                completion(.failure(error)) // NetworkError
            }
        }
    }

    func save(entity: E.Resource, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(E.relativePath)
        var request = URLRequest(url: url)
        request.httpMethod = E.method.rawValue
        request.httpBody = try? JSONEncoder().encode(entity)
        self.network.send(request) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    guard let dict = json, let success = dict["success"] as? Bool else {
                        return completion(RepositoryError.saveFailed)
                    }
                    completion(success ? nil : RepositoryError.saveFailed)
                } catch let error {
                    completion(error)
                }
            case .failure(let error):
                completion(error) // NetworkError
            }
        }
    }

    func delete(entity: E.Resource, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(E.relativePath)
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
                } catch let error {
                    completion(error)
                }
            case .failure(let error):
                completion(error) // NetworkError
            }
        }
    }
}

private struct List<T: Decodable>: Decodable {
    let totalPages: Int
    let results: [T]
}
