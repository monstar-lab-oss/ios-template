//
//  PostListViewModel.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Combine
import Domain
import Platform

class PostListViewModel: ViewModelType {
    // MARK: - Input
    struct Input {
        let refresh: AnyPublisher<Void, Never>
        let itemSelected: AnyPublisher<Int, Never>
        let loadMore: AnyPublisher<Void, Never>
    }
    // MARK: - Output
    struct Output {
        let results: AnyPublisher<[PostEntity], Never>
    }

    // MARK: - Properties
    private let coordinator: AnyCoordinatable<PostListCoordinator.Route>?
    private let useCase: AnyUseCase<Void, [PostEntity]>
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(coordinator: AnyCoordinatable<PostListCoordinator.Route>, useCase: AnyUseCase<Void, [PostEntity]>) {
        self.coordinator = coordinator
        self.useCase = useCase
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
                    self.useCase.executePublisher(())
                        .catch { _ -> Just<[PostEntity]> in
                            // TODO: Handle Error
                            return Just([])
                        }
                }
                .eraseToAnyPublisher()
        )
    }
}
