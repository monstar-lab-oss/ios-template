//
//  LoginViewModel.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//
import Foundation
import Combine

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
    
    // MARK: - Init
    init(coordinator: AnyCoordinatable<LoginCoordinator.Route>) {
        self.coordinator = coordinator
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
