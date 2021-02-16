//
//  {{cookiecutter.domain_model}}sEndpoint.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © 2021 {{cookiecutter.company_name}} All rights reserved.
//

import Domain

struct {{cookiecutter.domain_model}}sEndpoint: Endpoint {
    typealias Resource = Domain.{{cookiecutter.domain_model}}
    static let method: HTTPMethod = .get
    static let relativePath = "{{cookiecutter.domain_model|lower}}"
    static let headers = [
        "Content-Type": "application/json"
    ]
}
