//
//  {{cookiecutter.domain_model}}sRepository.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © 2021 {{cookiecutter.company_name}} All rights reserved.
//

import Domain
import Combine

final class {{cookiecutter.domain_model}}sRepository {

    enum CustomError: Error {
        case notFound
    }

    private let repository: RemoteRepository<{{cookiecutter.domain_model}}sEndpoint>

    init(repository: RemoteRepository<{{cookiecutter.domain_model}}sEndpoint>) {
        self.repository = repository
    }

    func fetch{{cookiecutter.domain_model}}s() -> AnyPublisher<[{{cookiecutter.domain_model}}], Error> {
        repository.queryPublisherForAll()
    }

    func fetch{{cookiecutter.domain_model}}(with id: Int) -> AnyPublisher<{{cookiecutter.domain_model}}, Error> {
        repository.queryPublisher(for: "id=\(id)")
            .flatMap { items -> Result<{{cookiecutter.domain_model}}, Error>.Publisher in
                guard !items.isEmpty else {
                    return .init(CustomError.notFound)
                }
                return .init(items[0])
            }.eraseToAnyPublisher()
    }

    func search{{cookiecutter.domain_model}}(with name: String) -> AnyPublisher<[{{cookiecutter.domain_model}}], Error> {
        repository.queryPublisher(for: "name=\(name)")
            .flatMap { items -> Result<[{{cookiecutter.domain_model}}], Error>.Publisher in
                guard !items.isEmpty else {
                    return .init(CustomError.notFound)
                }
                return .init(items)
            }.eraseToAnyPublisher()
    }
}
