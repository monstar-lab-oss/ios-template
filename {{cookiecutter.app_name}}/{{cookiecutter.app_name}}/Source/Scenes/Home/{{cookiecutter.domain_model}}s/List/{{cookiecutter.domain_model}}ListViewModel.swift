//
//  {{cookiecutter.domain_model}}ListViewModel.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Combine
import Domain
import Platform

class {{cookiecutter.domain_model}}ListViewModel: ViewModelType {

    struct Input {
        // Actions
        let refresh: AnyPublisher<Void, Never>
//        let loadMore: AnyPublisher<Void, Never>
        let selectedModel: AnyPublisher<Int, Never>
    }

    struct Output {
        let results: AnyPublisher<[{{cookiecutter.domain_model}}], Error>
    }

    var coordinator: AnyCoordinatable<{{cookiecutter.domain_model}}ListRoute>?
    private let useCase: Domain.{{cookiecutter.domain_model}}sUseCase

    init() {
        self.useCase = Platform.UseCaseProvider(
            baseURL: App.Server.baseURL
        ).make{{cookiecutter.domain_model}}sUseCase()
    }

    func transform(_ input: Input) -> Output {
        Output(
            results: input.refresh.setFailureType(to: Error.self)
                .flatMap(useCase.fetchAll)
                .eraseToAnyPublisher()
        )
//        return Output(
//            results: input.selectedModel
//                .handleEvents(receiveOutput: { [weak self] id in
//                    guard let this = self else { return }
//                    this.coordinator?.coordinate(to: .detail(id: id))
//                })
//                .flatMap { _ in Just([0]) }
//                .eraseToAnyPublisher()
//        )
    }
}
