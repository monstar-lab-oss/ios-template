//
//  LoginScene.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIViewController
import UIKit.UIStoryboard

final class LoginScene: Scene {
    private let vc: LoginViewController!
    init(dependencies: Dependencies) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        vc = storyboard.instantiateInitialViewController() as? LoginViewController
        vc.viewModel = dependencies.viewModel
        vc.viewModel.coordinator = dependencies.coordinator
    }
}

extension LoginScene {
    struct Dependencies {
        let coordinator: AnyCoordinatable<LoginRoute>
        let viewModel: LoginViewModel
    }

    var viewController: UIViewController {
        return vc
    }
}
