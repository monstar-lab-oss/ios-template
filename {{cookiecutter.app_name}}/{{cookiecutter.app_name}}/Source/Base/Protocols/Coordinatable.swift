//
//  Coordinatable.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

protocol Coordinatable: class {
    associatedtype Route
    func coordinate(to route: Route)
}

extension Coordinatable {
    func eraseToAnyCoordinatable() -> AnyCoordinatable<Route> {
        AnyCoordinatable(self)
    }
}
