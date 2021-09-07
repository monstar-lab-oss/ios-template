//
//  UseCaseProvider.swift
//  Platform
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    public func makeGetPostsUseCase() -> AnyUseCase<Void, [PostEntity]> {
        GetPostsUseCase(
            repository: postsRepository
        ).eraseToAnyUseCase()
    }
    
    public func makeGetPostDetailUseCase() -> AnyUseCase<Int, PostEntity> {
        GetPostDetailUseCase(
            repository: postsRepository
        ).eraseToAnyUseCase()
    }
    
    public func makeDoLoginUseCase() -> AnyUseCase<(username: String, password: String), Bool> {
        DoLoginUseCase(
            network: Network.default,
            baseURL: baseURL,
            endpoint: Endpoints.posts
        ).eraseToAnyUseCase()
    }
    
    public func makeGetPostCommentsUseCase(_ postId: Int) -> AnyUseCase<Int, [CommentEntity]> {
        GetPostCommentsUseCase(
            repository: RemoteRepository<CommentEntity, Comment>(
                baseURL: baseURL,
                network: Network.default,
                endpoint: Endpoints.commentsFor(postId: postId)
            )
        ).eraseToAnyUseCase()
    }
}

extension UseCaseProvider {
    
    var postsRepository: RemoteRepository<PostEntity, Post> {
        RemoteRepository<PostEntity, Post>(
            baseURL: baseURL,
            network: Network.default,
            endpoint: Endpoints.posts
        )
    }
}
