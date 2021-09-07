//
//  PostsUseCase.swift
//  Platform
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

final class GetPostsUseCase: Domain.GetPostsUseCase {
    
    private let repository: RemoteRepository<PostEntity, Post>

    init(repository: RemoteRepository<PostEntity, Post>) {
        self.repository = repository
    }

    func execute(_ parameters: Void, completion: ((Result<[PostEntity], Error>) -> Void)?) {
        repository.fetchAll { result in
            completion?(result.mapError { $0 as Error })
        }
    }
}
