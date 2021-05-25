//
//  {{cookiecutter.domain_model}}sUseCase.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Domain
import Combine

final class {{cookiecutter.domain_model}}sUseCase: Domain.{{cookiecutter.domain_model}}sUseCase {

    private let repository: {{cookiecutter.domain_model}}sRepository

    init(repository: {{cookiecutter.domain_model}}sRepository) {
        self.repository = repository
    }

    func fetchAll() -> AnyPublisher<[{{cookiecutter.domain_model}}], Error> {
        repository.fetch{{cookiecutter.domain_model}}s()
    }

    func fetch(with id: Int) -> AnyPublisher<{{cookiecutter.domain_model}}, Error> {
        repository.fetch(withId: id)
    }

    func search(with name: String) -> AnyPublisher<[{{cookiecutter.domain_model}}], Error> {
        repository.search(with: name)
    }
}
