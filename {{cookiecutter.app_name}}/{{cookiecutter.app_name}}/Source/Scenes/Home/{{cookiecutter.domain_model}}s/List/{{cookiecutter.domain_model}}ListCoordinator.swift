//
//  {{cookiecutter.domain_model}}Coordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Combine
import UIKit.UIViewController

enum {{cookiecutter.domain_model}}ListRoute {
    case detail(id: Int)
}

class {{cookiecutter.domain_model}}ListCoordinator: NavigationCoordinator {

    override func start() {
        super.start()
        show{{cookiecutter.domain_model}}List()
    }

    private func show{{cookiecutter.domain_model}}List() {
        let scene = {{cookiecutter.domain_model}}ListScene(
            dependencies: .init(
                coordinator: self.eraseToAnyCoordinatable(),
                viewModel: {{cookiecutter.domain_model}}ListViewModel()
            )
        )
        self.navigationController.setViewControllers([scene.viewController], animated: false)
    }

    private func show{{cookiecutter.domain_model}}Detail(id: Int) {
        let coordinator = {{cookiecutter.domain_model}}DetailCoordinator(
            navigationController: navigationController,
            sceneDependencies: .init(
                {{cookiecutter.domain_model|lower}}Id: id
            ))
        addChild(coordinator)
        coordinator.parentCoordinator = self.eraseToAnyCoordinator()
        coordinator.start()
    }
}

extension {{cookiecutter.domain_model}}ListCoordinator: Coordinatable {

    func coordinate(to route: {{cookiecutter.domain_model}}ListRoute) {
        switch route {
        case .detail(let id):
            show{{cookiecutter.domain_model}}Detail(id: id)
        }
    }
}
