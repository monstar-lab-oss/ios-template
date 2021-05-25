//
//  LoginCoordinator.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit

enum LoginRoute {
    case signUp
    case forgotPassword
}

class LoginCoordinator: NavigationCoordinator {

    override func start() {
        super.start()
        let scene = LoginScene(
            dependencies: .init(
                coordinator: self.eraseToAnyCoordinatable()
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
        case .signUp:
            showSignUp()
        case .forgotPassword:
            showForgotPassword()
        }
    }
}
