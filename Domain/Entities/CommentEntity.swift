//
//  CommentEntity.swift
//  Domain
//
//  Created by Aarif Sumra on 2021/09/03.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

public class CommentEntity: Entity {
    // Required
    public let id: Int
    public let postId: Int
    public let name: String
    public let email: String
    public let body: String
    // `Optional`s
    
    public init(id: Int, postId: Int, name: String, email: String, body: String) {
        self.id = id
        self.postId = postId
        self.name = name
        self.email = email
        self.body = body
    }
}

extension CommentEntity: Hashable {
    public static func == (lhs: CommentEntity, rhs: CommentEntity) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
