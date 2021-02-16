//
//  RepositoryType.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Domain
import Combine

public enum RepositoryError: Error {
    case queryFailed(Error)
    case saveFailed
    case deleteFailed
}

public protocol RepositoryType: class {
    associatedtype T
    func queryAll(_ completion: @escaping (Result<[T], Error>) -> Void)
    func query(with queryString: String, completion: @escaping (Result<[T], Error>) -> Void)
    func save(entity: T, completion: @escaping (Error?) -> Void)
    func delete(entity: T, completion: @escaping (Error?) -> Void)
}

extension RepositoryType where Self: Combinable {

    func queryPublisherForAll() -> AnyPublisher<[T], Error> {
        Future(queryAll).eraseToAnyPublisher()
    }

    func queryPublisher(for queryString: String) -> AnyPublisher<[T], Error> {
        Future { promise in
            self.query(with: queryString) { result in
                promise(result)
            }
        }.eraseToAnyPublisher()
    }

    func savePublisher(for entity: T) -> AnyPublisher<Void, Error> {
        Future { promise in
            self.save(entity: entity) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }

    func deletePublisher(for entity: T) -> AnyPublisher<Void, Error> {
        Future { promise in
            self.delete(entity: entity) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
}
