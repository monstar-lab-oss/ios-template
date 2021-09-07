//
//  PostDetailViewModel.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Combine
import Domain
import Platform

class PostDetailViewModel: ViewModelType {
    // MARK: - Input
    struct Input {
        // Actions
        let refresh: AnyPublisher<Void, Never>
        let loadData: AnyPublisher<Void, Never>
    }
    // MARK: - Output
    struct Output {
        let result: AnyPublisher<Result<PostEntity, Error>, Never>
        let comments: AnyPublisher<Result<[CommentEntity], Error>, Never>
    }
    
    // MARK: - Properties
    private let postId: Int
    private var coordinator: AnyCoordinatable<PostDetailScene.Route>?
    private let useCases: UseCases
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(postId: Int, coordinator: AnyCoordinatable<PostDetailScene.Route>?, useCases: UseCases) {
        self.postId = postId
        self.coordinator = coordinator
        self.useCases = useCases
    }
    
    // MARK: - I/O Transformer
    func transform(_ input: Input) -> Output {
        Output(
            result: input.loadData
                .flatMap { [unowned self]_ in
                    self.useCases.getPostDetailUseCase.executePublisher(self.postId)
                        .map {
                            Result<PostEntity,Error>.success($0)
                        }
                        .catch { error -> Just<Result<PostEntity, Error>> in
                            return Just(.failure(error))
                        }
                    
                }
                .eraseToAnyPublisher(),
            comments: input.refresh
                .flatMap { [unowned self]_ in
                    self.useCases.getPostCommentsUseCase.executePublisher(self.postId)
                        .map {
                            Result<[CommentEntity],Error>.success($0)
                        }
                        .catch { error -> Just<Result<[CommentEntity], Error>> in
                            return Just(.failure(error))
                        }
                    
                }
                .eraseToAnyPublisher()
        )
    }
}

extension PostDetailViewModel {
    struct UseCases {
        let getPostDetailUseCase: AnyUseCase<Int, PostEntity>
        let getPostCommentsUseCase: AnyUseCase<Int, [CommentEntity]>
    }
}
