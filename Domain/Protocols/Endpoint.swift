//
//  Endpoint.swift
//  Platform
//
//  Created by Hiroshi Oshiro on 2021-04-23.
//  Copyright © 2021 DWANGO Co., Ltd All rights reserved.
//

public protocol Endpoint {
    var relativePath: String { get }
    var headers: [String: String] { get }
}
