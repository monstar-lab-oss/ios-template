//
//  UseCaseProvider.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {

    private let repositoryProvider: RepositoryProvider

    public init(baseURL: URL) {
        self.repositoryProvider = RepositoryProvider(baseURL: baseURL)
    }

    public func make{{cookiecutter.domain_model}}sUseCase() -> Domain.{{cookiecutter.domain_model}}sUseCase {
        {{cookiecutter.domain_model}}sUseCase(
            repository: repositoryProvider.makePostsRepository()
        )
    }
}
