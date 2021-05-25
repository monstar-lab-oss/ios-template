//
//  {{cookiecutter.domain_model}}sEndpoint.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © 2021 {{cookiecutter.company_name}} All rights reserved.
//

import Domain

enum Endpoints: Endpoint {
    case {{cookiecutter.domain_model|lower}}s
    
    var relativePath: String {
        switch self {
        case .{{cookiecutter.domain_model|lower}}s:
            return "{{cookiecutter.domain_model|lower}}s"
        }
    }
    
    var headers: [String : String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}
