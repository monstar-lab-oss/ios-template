//
//  Comment.swift
//  Platform
//
//  Created by Aarif Sumra on 2021/09/03.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

struct Comment: Codable {
    // Required
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}

extension Comment: DomainEntityConvertible {
    
    init(from entity: CommentEntity) {
        self.id = entity.id
        self.postId = entity.postId
        self.name = entity.name
        self.email = entity.email
        self.body = entity.body
    }
    
    func asDomainEntity() -> CommentEntity {
        return CommentEntity(
            id: id,
            postId: postId,
            name: name,
            email: email,
            body: body
        )
    }
}


extension Comment: Hashable {
    public static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
