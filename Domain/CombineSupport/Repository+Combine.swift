//
//  Repository+Combine.swift
//  Platform
//
//  Created by Aarif Sumra on 2021/06/02.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

#if canImport(Combine)

import Combine

extension Repository {
    /// Returns a publisher that wraps a repository request to fetch all.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter id: The id of entity to be fetched.
    /// - Returns: A publisher that wraps repository fetch result with entity array
    func fetchAllPublisher() -> AnyPublisher<[T], RepositoryError> {
        Future(fetchAll).eraseToAnyPublisher()
    }
    /// Returns a publisher that wraps a repository request for a given ID.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter id: The id of entity to be fetched.
    /// - Returns: A publisher that wraps repository fetch result with entity
    func fetchPublisher(forId id: Int) -> AnyPublisher<T, RepositoryError> {
        Future { promise in
            self.fetch(withId: id) { result in
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
    /// Returns a publisher that wraps a repository request for a given query.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter queryItems: The array of `URLQueryItem`.
    /// - Returns: A publisher that wraps repository fetch result with entity array
    func queryPublisher(forQueryItems queryItems: [URLQueryItem]) -> AnyPublisher<[T], RepositoryError> {
        Future { promise in
            self.query(withQueryItems: queryItems) { result in
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
    /// Returns a publisher that wraps a repository request to save new entity.
    ///
    /// The publisher publishes data when the task completes, or terminates if the task fails with an error.
    /// - Parameter entity: The entity to be saved
    /// - Returns: A publisher that wraps repository save result
    func savePublisher(for entity: T) -> AnyPublisher<Void, RepositoryError> {
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
    /// Returns a publisher that wraps a repository request to update an existing entity.
    ///
    /// The publisher completes when the update completes, or terminates if the task fails with an error.
    /// - Parameter entity: The entity to be saved
    /// - Returns: A publisher that wraps repository save result
    func updatePublisher(for entity: T) -> AnyPublisher<Void, RepositoryError> {
        Future { promise in
            self.update(entity: entity) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    /// Returns a publisher that wraps a repository request for deletion.
    ///
    /// The publisher completes when the deletion completes, or terminates if the fails with an error.
    /// - Parameter entity: The entity to be saved
    /// - Returns: A publisher that wraps repository save result
    func deletePublisher(for entity: T) -> AnyPublisher<Void, RepositoryError> {
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
#endif
