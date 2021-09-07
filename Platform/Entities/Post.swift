//
//  Post.swift
//  Platform
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

struct Post: Codable {
    // Required
    let id: Int
    let title: String
    // `Optional`s
    var body: String? = nil
}

extension Post: DomainEntityConvertible {
    
    init(from entity: PostEntity) {
        self.id = entity.id
        self.title = entity.title
        self.body = entity.body
    }
    
    func asDomainEntity() -> PostEntity {
        return PostEntity(
            id: id,
            title: title,
            body: body
        )
    }
}


extension Post: Hashable {
    public static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
