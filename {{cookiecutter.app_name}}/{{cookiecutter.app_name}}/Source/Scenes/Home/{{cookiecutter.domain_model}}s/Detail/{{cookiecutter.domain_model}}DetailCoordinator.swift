//
//  {{cookiecutter.domain_model}}DetailCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Combine
import UIKit.UIViewController

enum {{cookiecutter.domain_model}}DetailRoute {

}

class {{cookiecutter.domain_model}}DetailCoordinator: NavigationCoordinator {

    struct SceneDependencies {
        let {{cookiecutter.domain_model|lower}}Id: Int
    }
    private let sceneDependencies: SceneDependencies

    init(navigationController: UINavigationController, sceneDependencies: SceneDependencies) {
        self.sceneDependencies = sceneDependencies
        super.init(viewController: navigationController)
    }

    override func start() {
        super.start()
        show{{cookiecutter.domain_model}}Detail()
    }

    private func show{{cookiecutter.domain_model}}Detail() {
        let scene = {{cookiecutter.domain_model}}DetailScene(
            dependencies: .init(
                coordinator: self.eraseToAnyCoordinatable(),
                viewModel: {{cookiecutter.domain_model}}DetailViewModel(
                    {{cookiecutter.domain_model|lower}}Id: sceneDependencies.{{cookiecutter.domain_model|lower}}Id
                )
            )
        )
        self.navigationController.pushViewController(scene.viewController, animated: true)
    }
}

extension {{cookiecutter.domain_model}}DetailCoordinator: Coordinatable {

    func coordinate(to route: {{cookiecutter.domain_model}}DetailRoute) {

    }
}
