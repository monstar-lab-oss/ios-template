//
//  PostEntity.swift
//  Domain
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Foundation

public class PostEntity: Entity {    
    // Required
    public let id: Int
    public let title: String
    // `Optional`s
    public var body: String?
    
    public init(id: Int, title: String, body: String? = nil) {
        self.id = id
        self.title = title
        self.body = body
    }
}

extension PostEntity: Hashable {
    public static func == (lhs: PostEntity, rhs: PostEntity) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
