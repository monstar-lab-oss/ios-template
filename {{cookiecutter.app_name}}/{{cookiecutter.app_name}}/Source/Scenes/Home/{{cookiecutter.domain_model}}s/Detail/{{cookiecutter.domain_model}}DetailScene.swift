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
    // MARK: - Properties
    private let vc: {{cookiecutter.domain_model}}DetailViewController!
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        vc = {{cookiecutter.domain_model}}DetailViewController.instantiate(
            with: {{cookiecutter.domain_model}}DetailViewModel(
                {{cookiecutter.domain_model|lower}}Id: dependencies.{{cookiecutter.domain_model|lower}}Id
            )
        )
    }
}

// MARK: - Scene Protocol
extension {{cookiecutter.domain_model}}DetailScene {
    struct Dependencies {
        let {{cookiecutter.domain_model|lower}}Id: Int
    }

    var viewController: UIViewController {
        return vc
    }
}
