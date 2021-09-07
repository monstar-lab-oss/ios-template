//
//  Network.swift
//  Domain
//
//  Created by Hiroshi Oshiro on 2021-04-23.
//  Copyright © 2021 DWANGO Co., Ltd All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case underlyingError(Error)
    case abnormalResponse(HTTPURLResponse)
    case emptyResponse
}

public protocol Networking: class {
    var session: URLSession { get }
    func send(_ request: URLRequest, completion: @escaping (Result<Data, NetworkingError>) -> Void)
}
