//
//  {{cookiecutter.domain_model}}DetailScene.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIViewController
import UIKit.UIStoryboard

final class {{cookiecutter.domain_model}}DetailScene: Scene {
    private let vc: {{cookiecutter.domain_model}}DetailViewController!
    init(dependencies: Dependencies) {
        let storyboard = UIStoryboard(name: "{{cookiecutter.domain_model}}Detail", bundle: nil)
        vc = storyboard.instantiateInitialViewController() as? {{cookiecutter.domain_model}}DetailViewController
        vc.viewModel = dependencies.viewModel
        vc.viewModel?.coordinator = dependencies.coordinator
    }
}

extension {{cookiecutter.domain_model}}DetailScene {
    struct Dependencies {
        let coordinator: AnyCoordinatable<{{cookiecutter.domain_model}}DetailRoute>
        let viewModel: {{cookiecutter.domain_model}}DetailViewModel
    }

    var viewController: UIViewController {
        return vc
    }
}
