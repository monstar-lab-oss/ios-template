//
//  Endpoint.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Domain

protocol Endpoint {
    associatedtype Resource: Codable
    static var method: HTTPMethod { get }
    static var relativePath: String { get }
    static var headers: [String: String] { get }
}
