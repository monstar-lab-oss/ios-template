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
    // MARK: - Input
    struct Input {
        let refresh: AnyPublisher<Void, Never>
        let itemSelected: AnyPublisher<Int, Never>
        let loadMore: AnyPublisher<Void, Never>
    }
    // MARK: - Output
    struct Output {
        let results: AnyPublisher<[{{cookiecutter.domain_model}}], Never>
    }

    // MARK: - Properties
    private let coordinator: AnyCoordinatable<{{cookiecutter.domain_model}}ListCoordinator.Route>?
    private let useCase: Domain.{{cookiecutter.domain_model}}sUseCase
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(coordinator: AnyCoordinatable<{{cookiecutter.domain_model}}ListCoordinator.Route>) {
        self.coordinator = coordinator
        self.useCase = Platform.UseCaseProvider(
            baseURL: App.Server.baseURL
        ).make{{cookiecutter.domain_model}}sUseCase()
    }

    // MARK: - I/O Transformer
    func transform(_ input: Input) -> Output {
        // Item selection handeled locally
        input.itemSelected.sink(receiveValue: { [weak self] id in
            self?.coordinator?.coordinate(to: .detail(id: id))
        }).store(in: &cancellables)
        
        return Output(
            results: input.refresh
                .flatMap { _ in
                    self.useCase.fetchAll()
                        .catch { _ -> Just<[{{cookiecutter.domain_model}}]> in
                            // TODO: Handle Error
                            return Just([])
                        }
                }
                .eraseToAnyPublisher()
        )
    }
}
