//
//  LoginScene.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIViewController
import UIKit.UIStoryboard

final class LoginScene {
    // MARK: - Properties
    private let vc: LoginViewController!
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        vc = LoginViewController.instantiate(
            with: LoginViewModel(
                coordinator: dependencies.coordinator
            )
        )
    }
}

// MARK: - Scene Protocol
extension LoginScene: Scene {
    struct Dependencies {
        let coordinator: AnyCoordinatable<LoginRoute>
    }

    var viewController: UIViewController {
        return vc
    }
}
