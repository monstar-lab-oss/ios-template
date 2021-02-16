//
//  UseCaseProvider.swift
//  Domain
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

public protocol UseCaseProvider {
    func make{{cookiecutter.domain_model}}sUseCase() -> {{cookiecutter.domain_model}}sUseCase
}
