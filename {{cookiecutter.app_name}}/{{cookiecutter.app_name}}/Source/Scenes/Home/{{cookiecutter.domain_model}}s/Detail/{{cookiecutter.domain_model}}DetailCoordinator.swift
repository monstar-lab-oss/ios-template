//
//  {{cookiecutter.domain_model}}DetailCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIViewController

// This Coordinator has no `enum Route`.
// It literally means that this is the last screen and no further navigation is possible,
// though you can go back. 😉
class {{cookiecutter.domain_model}}DetailCoordinator: NavigationCoordinator {
    // MARK: - Enums and Type aliases
    typealias SceneDependencies = {{cookiecutter.domain_model}}DetailScene.Dependencies
    
    // MARK: - Properties
    private let sceneDependencies: SceneDependencies
    
    // MARK: - Init
    init(navigationController: UINavigationController, sceneDependencies: SceneDependencies) {
        self.sceneDependencies = sceneDependencies
        super.init(viewController: navigationController)
    }

    override func start() {
        super.start()
        let scene = {{cookiecutter.domain_model}}DetailScene(
            dependencies: .init(
                {{cookiecutter.domain_model|lower}}Id: sceneDependencies.{{cookiecutter.domain_model|lower}}Id
            )
        )
        self.navigationController.pushViewController(scene.viewController, animated: true)
    }
}
