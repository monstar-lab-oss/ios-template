//
//  {{cookiecutter.domain_model}}Coordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIViewController

enum {{cookiecutter.domain_model}}ListRoute {
    case detail(id: Int)
}

class {{cookiecutter.domain_model}}ListCoordinator: NavigationCoordinator {

    override func start() {
        super.start()
        let scene = {{cookiecutter.domain_model}}ListScene(
            dependencies: .init(
                coordinator: self.eraseToAnyCoordinatable()
            )
        )
        self.navigationController.setViewControllers([scene.viewController], animated: false)
    }
}

// MARK: - ViewModel → Coordinator　Callbacks
extension {{cookiecutter.domain_model}}ListCoordinator: Coordinatable {
    
    func coordinate(to route: {{cookiecutter.domain_model}}ListRoute) {
        switch route {
        case .detail(let id):
            show{{cookiecutter.domain_model}}ListDetail(id: id)
        }
    }
    
    private func show{{cookiecutter.domain_model}}ListDetail(id: Int) {
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
