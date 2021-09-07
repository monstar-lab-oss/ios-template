//
//  LoginCoordinator.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

class LoginCoordinator: NavigationCoordinator {
    
    // MARK: - Properties
    private let useCaseProvider: UseCaseProvider
    
    // MARK: - Init
    init(useCaseProvider: UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        super.init()
    }
    
    // MARK: - Start and show root scene
    override func start() {
        super.start()
        let scene = LoginScene(
            dependencies: .init(
                coordinator: self.eraseToAnyCoordinatable(),
                useCaseProvider: useCaseProvider)
        )
        self.navigationController.setViewControllers([scene.view], animated: false)
    }
}

// MARK: - ViewModel → Coordinator　Callbacks
extension LoginCoordinator: Coordinatable {

    func coordinate(to route: LoginScene.Route) {
        switch route {
        case .signUp:
            showSignUp()
        case .forgotPassword:
            showForgotPassword()
        }
    }
    
    private func showSignUp() {
    }

    private func showForgotPassword() {
    }
}
