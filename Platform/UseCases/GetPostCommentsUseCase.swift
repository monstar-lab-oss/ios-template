//
//  GetPostCommentsUseCase.swift
//  Platform
//
//  Created by Aarif Sumra on 2021/09/03.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

final class GetPostCommentsUseCase: Domain.GetPostCommentsUseCase {
    
    private let repository: RemoteRepository<CommentEntity, Comment>

    init(repository: RemoteRepository<CommentEntity, Comment>) {
        self.repository = repository
    }

    func execute(_ parameters: Int, completion: ((Result<[CommentEntity], Error>) -> Void)?) {
        repository.fetchAll { result in
            completion?(result.mapError { $0 as Error })
        }
    }
}
