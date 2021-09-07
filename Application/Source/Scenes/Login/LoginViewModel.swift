//
//  LoginViewModel.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Combine
import Domain

class LoginViewModel: ViewModelType {

    // MARK: - Input
    struct Input {
        // Data
        let username: AnyPublisher<String?, Never>
        let password: AnyPublisher<String?, Never>
        // Actions
        let doLogin: AnyPublisher<Void, Never>
    }
    // MARK: - Output
    struct Output {
        let enableLogin: AnyPublisher<Bool, Never>
    }

    private let coordinator: AnyCoordinatable<LoginCoordinator.Route>?
    private let useCase: AnyUseCase<(username: String, password: String), Bool>

    
    // MARK: - Init
    init(coordinator: AnyCoordinatable<LoginScene.Route>, useCase: AnyUseCase<(username: String, password: String), Bool>) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    // MARK: - I/O Transformer
    func transform(_ input: Input) -> Output {
        return Output(
            enableLogin: Publishers.CombineLatest(input.username, input.password)
                .map { username, password in
                    (username?.isEmailValid() ?? false) && password?.count ?? 0 > 7
                }
                .eraseToAnyPublisher()
        )
    }
}

private extension String {

    private var emailPredicate: NSPredicate {
        let userid = "[A-Z0-9a-z._%+-]{1,}"
        let domain = "([A-Z0-9a-z._%+-]{1,}\\.){1,}"
        let regex = userid + "@" + domain + "[A-Za-z]{1,}"
        return NSPredicate(format: "SELF MATCHES %@", regex)
    }

    func isEmailValid() -> Bool {
        return emailPredicate.evaluate(with: self)
    }
}
