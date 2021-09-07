//
//  Network.swift
//  Domain
//
//  Created by Hiroshi Oshiro on 2021-04-23.
//  Copyright © 2021 DWANGO Co., Ltd All rights reserved.
//

public enum RepositoryError: Error {
    case underlyingError(Error)
    case saveFailed
    case updateFailed
    case deleteFailed
}

/// The fundamental repository has an entity type to operate with
public protocol Repository: class {
    /// The entity type repository holds
    associatedtype T: Entity
    /// Fetches an entity from the repository
    func fetch(withId id: Int, completion: @escaping (Result<T, RepositoryError>) -> Void)
    /// Queries the repository with query items
    func query(withQueryItems queryItems: [URLQueryItem], completion: @escaping (Result<[T], RepositoryError>) -> Void)
    /// Fetch all the entities from the repository
    func fetchAll(_ completion: @escaping (Result<[T], RepositoryError>) -> Void)
    /// Saves the new entity to the repository
    func save(entity: T, completion: @escaping (RepositoryError?) -> Void)
    /// Updates an existing entity from the repository
    func update(entity: T, completion: @escaping (RepositoryError?) -> Void)
    /// Deletes an existing entity from the repository
    func delete(entity: T, completion: @escaping (RepositoryError?) -> Void)
}
