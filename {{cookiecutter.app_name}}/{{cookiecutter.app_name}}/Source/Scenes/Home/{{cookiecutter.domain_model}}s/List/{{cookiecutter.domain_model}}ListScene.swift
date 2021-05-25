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
    // MARK: - Properties
    private let vc: {{cookiecutter.domain_model}}ListViewController!
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        vc = {{cookiecutter.domain_model}}ListViewController.instantiate(
            with: {{cookiecutter.domain_model}}ListViewModel(
                coordinator: dependencies.coordinator
            )
        )
    }
}

// MARK: - Scene Protocol
extension {{cookiecutter.domain_model}}ListScene: Scene {
    struct Dependencies {
        let coordinator: AnyCoordinatable<{{cookiecutter.domain_model}}ListRoute>
    }

    var viewController: UIViewController {
        return vc
    }
}

