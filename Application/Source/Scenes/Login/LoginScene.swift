//
//  LoginScene.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

final class LoginScene: Scene {
    // MARK: - Enums and Declarations
    enum Route {
        case signUp
        case forgotPassword
    }
    
    struct Dependencies {
        let coordinator: AnyCoordinatable<Route>
        let useCaseProvider: UseCaseProvider
    }
    
    // MARK: - Properties
    let view: LoginViewController
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        view = LoginViewController.instantiate(
            with: LoginViewModel(
                coordinator: dependencies.coordinator,
                useCase: dependencies.useCaseProvider.makeDoLoginUseCase()
            )
        )
    }
}
