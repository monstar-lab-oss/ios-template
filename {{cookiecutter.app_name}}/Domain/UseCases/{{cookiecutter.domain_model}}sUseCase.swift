//
//  {{cookiecutter.domain_model}}sUseCase.swift
//  Domain
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Combine

public protocol {{cookiecutter.domain_model}}sUseCase {
    func fetchAll() -> AnyPublisher<[{{cookiecutter.domain_model}}], Error>
    func fetch(with id: Int) -> AnyPublisher<{{cookiecutter.domain_model}}, Error>
    func search(with name: String) -> AnyPublisher<[{{cookiecutter.domain_model}}], Error>
}
