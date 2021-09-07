//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

public protocol DoLoginUseCase: UseCase {}
public protocol GetPostsUseCase: UseCase {}
public protocol GetPostDetailUseCase: UseCase {}
public protocol GetPostCommentsUseCase: UseCase {}

public protocol UseCaseProvider {
    func makeDoLoginUseCase() -> AnyUseCase<(username: String, password: String), Bool>
    func makeGetPostsUseCase() -> AnyUseCase<Void, [PostEntity]>
    func makeGetPostDetailUseCase() -> AnyUseCase<Int, PostEntity>
    func makeGetPostCommentsUseCase(_ postId: Int) -> AnyUseCase<Int, [CommentEntity]>
}
