//
//  AnyCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIViewController

struct AnyCoordinator {

    private let base: CoordinatorType

    init(_ base: CoordinatorType) {
        self.base = base
    }

    func removeChild(_ coordinator: CoordinatorType) {
        base.removeChild(coordinator)
    }
}
