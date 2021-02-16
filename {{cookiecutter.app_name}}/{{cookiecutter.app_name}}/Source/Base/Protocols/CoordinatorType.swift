//
//  CoordinatorType.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Combine
import UIKit.UIViewController

protocol ChildCoordinatorType {
    var parentCoordinator: AnyCoordinator? { get }
}

protocol CoordinatorType: class {
    var childCoordinators: [CoordinatorType] { get }
    var viewController: UIViewController { get }
    func start()
    func addChild(_ coordinator: CoordinatorType)
    func removeChild(_ coordinator: CoordinatorType)
}

extension CoordinatorType {
    func eraseToAnyCoordinator() -> AnyCoordinator {
        AnyCoordinator(self)
    }
}
