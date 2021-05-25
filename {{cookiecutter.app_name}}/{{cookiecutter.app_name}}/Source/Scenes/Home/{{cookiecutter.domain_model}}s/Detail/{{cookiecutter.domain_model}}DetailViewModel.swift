//
//  {{cookiecutter.domain_model}}DetailViewModel.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Combine
import Domain
import Platform

class {{cookiecutter.domain_model}}DetailViewModel: ViewModelType {
    // MARK: - Input
    struct Input {
        // Actions
        let loadData: AnyPublisher<Void, Never>
    }
    // MARK: - Output
    struct Output {
        let result: AnyPublisher<Result<{{cookiecutter.domain_model}}, Error>, Never>
    }
    
    // MARK: - Properties
    private let {{cookiecutter.domain_model|lower}}Id: Int
    private let useCase: Domain.{{cookiecutter.domain_model}}sUseCase
    
    // MARK: - Init
    init({{cookiecutter.domain_model|lower}}Id: Int) {
        self.{{cookiecutter.domain_model|lower}}Id = {{cookiecutter.domain_model|lower}}Id
        self.useCase = Platform.UseCaseProvider(
            baseURL: App.Server.baseURL
        ).make{{cookiecutter.domain_model}}sUseCase()
    }
    
    // MARK: - I/O Transformer
    func transform(_ input: Input) -> Output {
        return Output(
            result: input.loadData
                .flatMap { _ in
                    self.useCase.fetch(with: self.{{cookiecutter.domain_model|lower}}Id)
                        .map {
                            Result<{{cookiecutter.domain_model}},Error>.success($0)
                        }
                        .catch { error -> Just<Result<{{cookiecutter.domain_model}}, Error>> in
                            return Just(.failure(error))
                        }
                }
                .eraseToAnyPublisher()
        )
    }
}
