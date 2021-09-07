//
//  PostsEndpoint.swift
//  Platform
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain

enum Endpoints: Endpoint {
    case posts
    case commentsFor(postId: Int)
    
    var relativePath: String {
        switch self {
        case .posts:
            return "posts"
        case .commentsFor(let postId):
            return "posts/\(postId)/comments"
        }
    }
    
    var headers: [String : String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}
