//
//  RepositoryProvider.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © 2021 {{cookiecutter.company_name}} All rights reserved.
//

import Foundation

final class RepositoryProvider {

    private let baseURL: URL
    private let network: Network

    init(baseURL: URL) {
        self.baseURL = baseURL
        self.network = Network(session: URLSession.shared)
    }

    public func make{{cookiecutter.domain_model}}sRepository() -> {{cookiecutter.domain_model}}sRepository {
        {{cookiecutter.domain_model}}sRepository(
            repository: .init(
                baseURL: baseURL,
                network: network
            )
        )
    }
}
