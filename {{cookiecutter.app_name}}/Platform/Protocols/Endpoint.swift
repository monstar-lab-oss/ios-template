//
//  Endpoint.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Domain

protocol Endpoint {
    var relativePath: String { get }
    var headers: [String: String] { get }
}
