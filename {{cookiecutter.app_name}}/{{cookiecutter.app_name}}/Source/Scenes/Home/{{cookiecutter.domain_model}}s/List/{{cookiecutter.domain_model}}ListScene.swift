//
//  {{cookiecutter.domain_model}}ListScene.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//
import UIKit.UIViewController
import UIKit.UIStoryboard

final class {{cookiecutter.domain_model}}ListScene {
    private let vc: {{cookiecutter.domain_model}}ListViewController!
    init(dependencies: Dependencies) {
        let storyboard = UIStoryboard(name: "{{cookiecutter.domain_model}}List", bundle: nil)
        vc = storyboard.instantiateInitialViewController() as? {{cookiecutter.domain_model}}ListViewController
        vc.viewModel = dependencies.viewModel
        vc.viewModel?.coordinator = dependencies.coordinator
    }
}

extension {{cookiecutter.domain_model}}ListScene: Scene {
    struct Dependencies {
        let coordinator: AnyCoordinatable<{{cookiecutter.domain_model}}ListCoordinator.Route>
        let viewModel: {{cookiecutter.domain_model}}ListViewModel
    }

    var viewController: UIViewController {
        return vc
    }
}
