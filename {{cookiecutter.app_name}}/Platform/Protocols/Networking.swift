//
//  Networking.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © 2021 {{cookiecutter.company_name}} All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case underlyingError(Error)
    case abnormalResponse(HTTPURLResponse)
    case emptyResponse
}

protocol Networking: class {
    var session: URLSession { get }
    func send(_ request: URLRequest, completion: @escaping (Result<Data, NetworkingError>) -> Void)
}
