//
//  Combinable.swift
//  Platform
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © 2021 {{cookiecutter.company_name}} All rights reserved.
//

import Combine

public protocol Combinable {}

extension Networking where Self: Combinable {
    func sendRequestPublisher(_ request: URLRequest) -> AnyPublisher<Result<Data, NetworkingError>, Never> {
        Future { promise in
            self.send(request) { result in
                promise(.success(result))
            }
        }.eraseToAnyPublisher()
    }
}
