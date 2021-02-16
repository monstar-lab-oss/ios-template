//
//  LoginCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine

enum LoginRoute {
    case login
    case signUp
    case forgotPassword
}

class LoginCoordinator: NavigationCoordinator {

    override func start() {
        super.start()
        showLogin()
    }

    private func showLogin() {
        let scene = LoginScene(
            dependencies: .init(
                coordinator: self.eraseToAnyCoordinatable(),
                viewModel: LoginViewModel()
            )
        )
        self.navigationController.setViewControllers([scene.viewController], animated: false)
    }

    private func showSignUp() {
    }

    private func showForgotPassword() {
    }
}

extension LoginCoordinator: Coordinatable {

    func coordinate(to route: LoginRoute) {
        switch route {
        case .login:
            showLogin()
        case .signUp:
            showSignUp()
        case .forgotPassword:
            showForgotPassword()
        }
    }
}
